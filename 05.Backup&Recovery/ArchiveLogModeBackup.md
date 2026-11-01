# Archive Log Mode
- Log Switch 발생시, arc Background 프로세스가 CURRENT Group Redo Log 파일을 복사 ( 後 Redo Log 파일이 INACTIVE 상태로 변한다 )
- DB 운영중에도 Backup 가능
- 일관성 없는 Backup ( Online Backup = Open Backup = Hot Backup )
  - ```SQL
    alter database begin backup; /* DB Level Online Backup 시작 ( Full Checkpoint 발생 ) */

    ! cp -v /u01/app/oracle/oradata/ORA19C/*.dbf /home/oracle/backup/arch/open/
    
    alter database end backup;

    alter system archive log current; /* CURRENT Group Redo Log File Archive */
    --alter system switch logfile;
    ```
    - ' ! cp -v /u01/app/oracle/oradata/ORA19C/\*.dbf /home/oracle/backup/arch/open/ ' == OS 內 .dbf File Backup ( cp )
    - Online 백업 시점의 내용이 들어있는 Redo Log File Check ( Memo )
- ```SQL
  archive log list;
  --Database log mode              Archive Mode
  --Automatic archival             Enabled
  --Archive destination            /home/oracle/arch2
  --Oldest online log sequence      30
  --Next log sequence to archive    32
  --Current log sequence            32
  ```
  - Automatic archival : arc Background Process 동작
  - Archive destination : Archive 생성되는 Dir ( 마지막 경로만 표시 )
- ```SQL
  select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, b.time
  from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
  where a.file# = b.file#;
  ```
  - ' CHANGE# ' == 백업시 Checkpoint 시점
  - ' TIME ' == 백업 시각
- No Archive Log 모드에서, Archive Log 모드로 변경시, Archive 생성 위치 지정 필수
  - ```SQL
    alter system set log_archive_dest_1="/home/oracle/backup/arch1/ mandatory" scope = spfile;
    alter system set log_archive_dest_2="/home/oracle/backup/arch2/ optional" scope = spfile;
    ```
    - ' mandatory ' == Archive 작업이 성공적으로 마쳐야만, Redo Log File 재사용 가능 ( 공간 부족시, 공간 확보시까지 Wait 단계로 빠져서 대기 )
    - ' optional ' == Archive 작업이 성공적으로 마쳐지지 않더라도, Redo Log File 재사용 가능 ( 공간 부족시, Archive Log File 미생성 )
- ```SQL
  show parameter log_archive_format;

  alter system set log_archive_format = 'arch_%t_%s_%r.arc' scope = spfile; /* Archive Log File 名 Format 재설정 */
  ```
  |NAME|TYPE|VALUE|
  :---|:---|:---|
  log_archive_format|string|%t_%s_%r.dbf|
  > Archive Log File 名 Format
  - %t : Thread Number
  - %s : Redo Log Sequence Number
  - %r : ' v$database_incarnation ' 內 ' RESETLOGS_ID '
- No Archive Log 모드에서, Archive Log 모드로 변경시, DB 정상 Down 後 Mount 시점에서 ' alter database archivelog; ' 수행 後 ' alter database open; '
  - Archive Log 모드에서, No Archive Log 모드로 변경시, DB 정상 Down 後 Mount 시점에서 ' alter database noarchivelog; ' 수행 後 ' alter database open; '
---
</br></br></br>


### DB 운영중, 하나의 Data File 손상 時 Archive 완전 복구 Scenario
0. DB 운영중, Data File 손상 ( rm )
```CMD
rm /u01/app/oracle/oradata/ORA19C/users01.dbf
```
</br>

1. SQL 작업중 Data File 손상 감지
```SQL
select count(*) from hr.employees; /* 다른 Data File 내용은, 정상 수행 */


select * from hr.new; /* Data File 손상 前 작업중이었다면, 기존 메모리 내용이 보인다 */
create table hr.new2 tablespace users as select * from hr.employees; /* Data File 직접 Access 필요하여 ERR 발생 */
```
</br>

2. 문제의 Data File 탐색
```SQL
select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'NEW' /* 대문자 입력 필수 */
and e.owner = 'HR'; /* 대문자 입력 필수 */
--/u01/app/oracle/oradata/ORA19C/users01.dbf


select * from v$recover_file;
```
</br>

3. Recovery 필요 파일들만 Offline 後 상황을, 사내 전체 공지
```SQL
alter tablespace users offline immediate; /* Archive Log Mode 時 문법 ( DB Open 後 사용 가능 ) */
--alter database datafile 7 offline; /* Mount 시점에서의 문법 */
```
> System Data File, Default Temporary Tablespace 등록되어있는, Temporary 테이블스페이스는 Offline 처리 불가 ( Mount 시점에서 Recovery )
</br>

4. OS 內 Restore 작업
```CMD
cp -v /home/oracle/backup/arch/open/users01.dbf /u01/app/oracle/oradata/ORA19C/
```
</br>

5. Redo 적용
```SQL
recover tablespace users;
--recover datafile 7;
```
> ' Specify log: {<RET>=suggested | filename | AUTO | CANCEL} ' 질문 時 ' auto ' 입력
</br>

6. Online
```SQL
alter tablespace users online;
```
---