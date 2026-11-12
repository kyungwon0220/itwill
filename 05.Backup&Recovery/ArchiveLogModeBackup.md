# Archive Log Mode
- Log Switch 발생시, arc Background 프로세스가 CURRENT Group Redo Log 파일을 복사 ( 後 Redo Log 파일이 INACTIVE 상태로 변한다 )
- DB 운영중에도 Backup 가능
- 일관성 없는 Backup ( Online Backup = Open Backup = Hot Backup )
  - ```SQL
    alter database begin backup; /* DB Level Online Backup 시작 ( Full Checkpoint 발생 ) */

    ! cp -v /u01/app/oracle/oradata/ORA19C/*.dbf /home/oracle/backup/arch/open/
    
    alter database end backup;


    alter system archive log current; /* Backup 後 CURRENT Group Redo Log File Archive 습관화 권장 */
    --alter system switch logfile;
    ```
    - ' ! cp -v /u01/app/oracle/oradata/ORA19C/\*.dbf /home/oracle/backup/arch/open/ ' == OS 內 .dbf File Backup ( cp )
    - Online 백업 시점의 내용이 들어있는 Redo Log File Check ( Memo )
- Tablespace Level Backup
  - ```SQL
    alter tablespace data_tbs begin backup;


    alter system archive log current; /* Backup 後 CURRENT Group Redo Log File Archive 습관화 권장 */
    --alter system switch logfile;
    ```
    - Tablespace backup 수행 時 Tablespace 內 모든 Data File Backup 시각이 갱신되므로, Data 파일별 Backup 일지 관리 필수 ( 차후, Backup 필요한 Data 파일별 ' CHANGE# ' 시점 확인 필요 )
    - Tablespace 정보 등의 Control File 수정 사항 발생시, [Control File Backup](../04.DBA/261007.md#control-file-backup) 및 Trace File 생성 습관화 권장
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
  - Archive destination : Archive 생성되는 Dir
    - ' Archive destination ' 값인 ' /home/oracle/arch2 ' 경로에 Archive Backup File 부재시, Recovery 불가 ( Archive File 다중화시에도, Recover 시도시 ' Archive destination ' 경로에 Archive Backup 파일이 있는지 확인 )
- ```SQL
  select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') backup_time
  from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
  where a.file# = b.file#;
  ```
  - ' CHANGE# ' == 백업시 Checkpoint 시점
  - ' TIME ' == 백업 시각
- No Archive Log 모드에서, Archive Log 모드로 변경시, Archive 생성 위치 지정 필수
  - ```SQL
    alter system set log_archive_dest_1="location=/home/oracle/backup/arch1/ mandatory" scope = spfile;
    alter system set log_archive_dest_2="location=/home/oracle/backup/arch2/ optional" scope = spfile;
    ```
    > DB 재부팅시부터 Archive File 생성지 적용
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


### DB 운영중, Data File 손상 時 완전 복구 Scenario
0. DB 운영중, Data File 손상 ( rm )
```CMD
rm /u01/app/oracle/oradata/ORA19C/users01.dbf
```
</br>

1. SQL 작업중 Data File 손상 감지
```SQL
select count(*) from hr.employees; /* 다른 Data File 내용은, 정상 수행 */


select * from hr.new; /* Data File 손상 前 작업중이었다면, Dirty Buffer Cache 內 Buffer 내용 정상 출력 */
create table hr.new2 tablespace users as select * from hr.employees; /* CTAS == Direct Write (Data File 직접 Access 필요) 방식으로, ERR 발생 */
```
> System Data File 손상시, DB Down ( Mount 시점에서 Recover 필요 )
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

4.5.
- 백업본이 없는 Data 파일의 Recovery 필요시, 빈 껍데기 Data File 생성 ( Redo 정보 존재시 )
  - ```CMD
    alter database create datafile '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf'; /* 크기는, 처음 생성시에 지정한대로 Auto 지정ㄷ */
    --alter database create datafile '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' as '/home/oracle/backup/tmp/test01.dbf'; /* 기존 테이블스페이스의 Data 파일의 경로 및 파일명을 새로 생성 가능 */
    ```
    > Tablespace 생성시부터 현재까지의 Redo 정보가 없다면, Recovery 불가
</br>

- Offline Data 파일을 복구하면서, Data File 경로를 변경하고 싶은 경우
```SQL
alter database rename file '/home/oracle/backup/tmp/test01.dbf' to '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf';
```

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
</br></br></br>


### DB 운영중, 하나의 Tablespace 內 일부 Data File 손상 時 완전 복구 Scenario
1. 하나의 Tablespace 內 2개의 Data File 사용중 가정
```SQL
create tablespace data_tbs datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' size 5m;
alter tablespace data_tbs add datafile '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf' size 5m;


create table hr.emp tablespace data_tbs as select * from hr.employees;
insert into hr.emp select * from hr.emp;
select count(*) from hr.emp;
--54784
commit;


select f.tablespace_name, f.file_name, count(*)
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP2' /* 대문자 입력 필수 */
and e.owner = 'HR' /* 대문자 입력 필수 */
group by f.tablespace_name, f.file_name;
--DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	16
--DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2
```
</br>

2. 하나의 Data File 손상 감지  ( rm )
```CMD
rm /u01/app/oracle/oradata/ORA19C/data_tbs02.dbf


create table hr.emp2 tablespace data_tbs as select * from hr.employees; /* Tablespace 內 Table 생성 실패 ERR */
```
</br>

3. Tablespace Level [OFFLINE TEMPORARY](../04.DBA/261015.md#offline-mode-tablespace)
```SQL
alter tablespace data_tbs offline temporary;


select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#; /* Control 파일이 갖고있는, Data File 정보 */
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2705395	ONLINE
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	2705395	SYSTEM
--2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2708782	OFFLINE /* 손상되지 않았지만, 같은 테이블스페이스라서 OFFLINE */
--4	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2708782	OFFLINE /* 손상된 ' data_tbs02.dbf ' 파일만 OS 上 Restroe ( cp ) */
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	2705395	ONLINE
--5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	2705395	ONLINE
```
> ' v$datafile ' 內 STATUS == 평소의 ' RECOVER ' 아닌,  ' OFFLINE '
</br>

4. OS 內 Restore 작업
```CMD
cp -v /home/oracle/backup/tmp/data_tbs02.dbf /u01/app/oracle/oradata/ORA19C/
```
</br>

5. Redo 적용
```SQL
recover datafile 4;
```
</br>

6. Online
```SQL
alter tablespace data_tbs online;
```
---
</br></br></br>


### DB 정상 Down 後 Control File 손상 時 완전 복구 Scenario
0. Online Bakcup 시점 이후, Tablespace 생성 後 Backup 없이, DB 정상 Down 가정
```SQL
create tablespace data_tbs datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' size 5m;
create table hr.data_emp(id number) tablespace data_tbs;
insert into hr.data_emp values(4);
select * from hr.data_emp;
commit;


shutdown immediate;
```
</br>

1. Control File 손상 後 DB Open 시도
```CMD
rm /u01/app/oracle/oradata/ORA19C/control01.ctl;

startup;
```
> ERR 발생하며, Nomount 시점까지 Open ( Control File 손상 감지 )
</br>

2. 백업본 Control File Restore 및 DB Mount 시점까지 Open
```CMD
cp /home/oracle/backup/control01.ctl  /u01/app/oracle/oradata/ORA19C/

alter database mount;
```
</br>

3. [Control File 재생성](261007.md#control-file-remake) 작업
- 0. ```SQL
     alter database backup controlfile to trace as '/u01/app/oracle/oradata/ORA19C/control_trace.txt';
     ```
     > Trace File 없을시, 생성
</br>

- 1. DB Down 後 Redo 손상이 없는 경우기에, 백업본 Control Trace File 내용 上 ' NORESETLOGS ' Part, TEMPFILE Part 발췌
  - ```CMD
    shutdown abort;

    vim  /u01/app/oracle/oradata/ORA19C/control_trace.txt
    ```
    ```TEXT
    67 STARTUP NOMOUNT
    68 CREATE CONTROLFILE REUSE DATABASE "ORA19C" NORESETLOGS  ARCHIVELOG
    69     MAXLOGFILES 16
    70     MAXLOGMEMBERS 3
    71     MAXDATAFILES 100
    72     MAXINSTANCES 8
    73     MAXLOGHISTORY 292
    74 LOGFILE
    75   GROUP 1 '/u01/app/oracle/oradata/ORA19C/redo01.log'  SIZE 200M BLOCKSIZE 512,
    76   GROUP 2 '/u01/app/oracle/oradata/ORA19C/redo02.log'  SIZE 200M BLOCKSIZE 512,
    77   GROUP 3 '/u01/app/oracle/oradata/ORA19C/redo03.log'  SIZE 200M BLOCKSIZE 512
    --78 -- STANDBY LOGFILE
    79 DATAFILE
    80   '/u01/app/oracle/oradata/ORA19C/system01.dbf',
    81   '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf',
    82   '/u01/app/oracle/oradata/ORA19C/sysaux01.dbf',
    --83   '/u01/app/oracle/product/19.3.0/dbhome_1/dbs/UNNAMED00004',
    '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf',
    84   '/u01/app/oracle/oradata/ORA19C/undo01.dbf',
    85   '/u01/app/oracle/oradata/ORA19C/users01.dbf'
    86 CHARACTER SET AL32UTF8
    87 ;
    ```
    - 78 Line ' STANDBY LOGFILE ' 부분 삭제 ( 공백 포함 )
    - 83 Line ' /u01/app/oracle/product/19.3.0/dbhome_1/dbs/UNNAMED00004 ' == Control File 백업본 이후에 생성되어 ' '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf' ' Tablespace 수동 입력 필요
    ```TEXT
    109 ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/app/oracle/oradata/ORA19C/temp01.dbf' REUSE;
    ```
</br>

- 2. DB Down 상태에서, 명령처럼 붙여넣기 後 DB Open
  ```SQL
  alter database open;
  ```
  > 명령처럼 붙여넣기 성공시, Auto Mount 시점으로 진입ㄷ
</br>

- 3. 발췌했던, Temp File Part REUSE
  ```SQL
  ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/app/oracle/oradata/ORA19C/temp01.dbf' REUSE;


  select * from v$tempfile;
  --2498709	2026/11/05 15:01:52	3	1	ONLINE	READ WRITE	33554432	4096	33554432	8192	/u01/app/oracle/oradata/ORA19C/temp01.dbf	0
  ```
---
</br></br></br>


### Tablespace 삭제 後 Time Base Recovery Scenario
- 되돌리고자는 시간대의 백업본 존재 필수
0. Tablespace 삭제 및 시각 Check
```SQL
drop tablespace data_tbs including contents and datafiles;
```
```CMD
grep -i 'drop' -C2 /u01/app/oracle/diag/rdbms/ora19c/ora19c/trace/alert_ora19c.log | tail -n 10
--2026-11-05T16:22:27.886199+09:00
--drop tablespace data_tbs including contents and datafiles
--2026-11-05T16:22:31.026070+09:00
--Deleted file /u01/app/oracle/oradata/ORA19C/data_tbs01.dbf
--Completed: drop tablespace data_tbs including contents and datafiles
```
</br>

1. DB Down 後 되돌리고 싶은 시간대의, 모든 Data File, Control File Restore
```CMD
cp /home/oracle/backup/*. /u01/app/oracle/oradata/ORA19C/
```
</br>

2. Mount 시점까지 DB Open
```SQL
startup mount;
```
</br>

3. Recovery
```SQL
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';


recover database using backup controlfile until time '2026-11-05 16:22:00' /* 되돌리고자는 시간대 지정 */
```
> ' Specify log: {<RET>=suggested | filename | AUTO | CANCEL} ' 질문 時 ' auto ' 입력
</br>

3.5. Recovery 마지막 시점 ( CURRENT Redo Log 정보 ) Archive Backup Log File 없을시, Redo Log 파일로 존재하는지 Check
```CMD
cat /u01/app/oracle/diag/rdbms/ora19c/ora19c/trace/alert_ora19c.log | grep -C2 'sequence 3'
```
```TEXT
--2026-11-05T14:44:12.825493+09:00
--ARC2 started with pid=42, OS id=24202
--Starting background process ARC3
--Thread 1 opened at log sequence 3
--  Current log# 3 seq# 3 mem# 0: /u01/app/oracle/oradata/ORA19C/redo03.log
```
> ' /u01/app/oracle/oradata/ORA19C/redo03.log ' 파일로 Recovery
</br>

4. DB Open
```SQL
alter database open resetlogs;
```
---
