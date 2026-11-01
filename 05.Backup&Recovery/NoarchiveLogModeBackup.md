# Noarchive Log Mode Backup
- Redo 정보가 없으면, 백업 시점 이후의 작업 내용은 복구 불가 ( 백업 시점으로의, [불완전 복구](#cancle-base-recovery) 가능 )
  - 백업 시점 이후의 Redo 정보 존재시, 완전 복구 가능
- DB 정상 종료 後 Whole Backup 진행 ( shutdown { NORMAL || TRANSACTIONAL || IMMEDIATE} )
  - 필수 Backup 대상 : 모든 Data File, Control File
  - 선택적 Backup 대상 : Redo Log File, 초기 파라미터 File, 패스워드 File
- 일관성 있는 Backup 稱 ( Close Backup = Cold Backup = Offline Backup ) : 모든 Data 파일의 Checkpoint, Control 파일의 Checkpoint, Redo Checkpoint 정보가 일치하는 Backup
</br></br></br>
## Step
0. 일지 작성 준비
```SQL
select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 */
select name, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile; /* 파일별 Checkpoint 시점과, 발생한 시각 */
```
1. DB 정상 종료
```SQL
shutdown immediate;
```
> shutdown { NORMAL || TRANSACTIONAL || IMMEDIATE}
2. OS 內 대상 File 복사 ( cp )
```CMD
cp -v /u01/app/oracle/oradata/ORA19C/* /home/oracle/backup/noarch/
```
3. DB Open
```SQL
startup;
```
4. pfile 백업본 생성
```SQL
create pfile='/home/oracle/backup/noarch/initora19c.ora' from spfile;
```
5. Backup 일지 작성
```CMD
$ ls -l /home/oracle/backup/noarch/
total 2451012
-rw-r--r--. 1 oracle oinstall       638 Oct 31 23:04 backup_time_memo.txt
-rw-r-----. 1 oracle oinstall  10600448 Oct 31 22:58 control01.ctl
-rw-r--r--. 1 oracle oinstall      1148 Oct 31 23:09 initora19c.ora
-rw-r-----. 1 oracle oinstall 209715712 Oct 31 22:58 redo01.log
-rw-r-----. 1 oracle oinstall 209715712 Oct 31 22:58 redo02.log
-rw-r-----. 1 oracle oinstall 209715712 Oct 31 22:58 redo03.log
-rw-r-----. 1 oracle oinstall 555753472 Oct 31 22:58 sysaux01.dbf
-rw-r-----. 1 oracle oinstall 943726592 Oct 31 22:58 system01.dbf
-rw-r-----. 1 oracle oinstall  33562624 Oct 31 22:58 temp01.dbf
-rw-r-----. 1 oracle oinstall 361766912 Oct 31 22:58 undotbs01.dbf
-rw-r-----. 1 oracle oinstall   5251072 Oct 31 22:58 users01.dbf
```
> 백업 위치 정보 등
---
</br></br></br>


### DB 운영중, 하나의 Data File 손상으로, DB Down 時 완전 복구 Scenario
0. SQL 작업중이라는 가정
```SQL
create table hr.emp(id number, name varchar2(30)) tablespace users;
insert into hr.emp(id, name) values(1, 'oracle1');
select * from hr.emp;
commit; /* 유저 Session 上 Suss */
```
</br>

1. Data File 손상으로, DB Down 상황
```CMD
rm /u01/app/oracle/oradata/ORA19C/users01.dbf
```
```SQL
ALTER SYSTEM CHECKPOINT; /* Database Buffer Cache 內 Dirty 버퍼를 Data 파일에 기록하는, DBWR 동작 유발 */
```
> ERR 발생하며 DB Down ( Data File 손상을 알게되는 시점 )
</br>

2. DB Open 시도시, ERR 발생하며 Mount 시점까지 Open
```SQL
startup;

select status from v$instance; /* 현재 DB Open 시점 조회 */
--    MOUNTED

select * from v$recover_file; /* Recovery 필요 대상 File 조회 */
--    7	ONLINE	ONLINE	FILE NOT FOUND	0		0
```
> 만약 System Data File 손상시, System Data 파일은 Offline 처리가 불가하므로 Mount 시점에서만 Recovery 가능
</br>

3. Recovery 필요 Data File Offline 後 DB Open 및 상황을, 사내 전체 공지
```SQL
alter database datafile 7 offline drop;  /* Noarchive Log Mode 時 문법 */

alter database open;
```
</br>

4. OS 內 Restore 작업
```CMD
cp -v /home/oracle/backup/tmp/users01.dbf /u01/app/oracle/oradata/ORA19C/
```
</br>

4.5.
- 백업본이 없는 Data 파일의 Recovery 필요시, 빈 껍데기 File 생성
  - ```CMD
    alter database create datafile '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf'; /* 크기는, 처음 생성시에 지정한대로 자동으로 지정ㄷ */
    ```
    > 당연히, 이도 Tablespace 생성시부터 현재까지의 Redo 정보가 없다면, Recovery 불가
</br>

- Undo Tablespace 파일이 손상 되었는데, Redo 정보가 없을시, 새로 사용할 Undo Tablespace File 생성 및 사용 지정
  - ```SQL
    create undo tablespace undo1 datafile '/u01/app/oracle/oradata/ORA19C/undo01.dbf' size 10M autoextend on; /* 새로운 Undo Tablespace 생성 */
    alter system set undo_tablespace = undo1 scope = both; /* undo1 Tablespace 사용 지정 */
    ```
</br>

5. Recovery
```SQL
recover tablespace users;
--recover datafile 7;
--recover datafile '/u01/app/oracle/oradata/ORA19C/users01.dbf';

```
> Restore 가져온 백업본 Checkpoint 시점부터의 Redo Log 정보 없을시, [불완전 복구](#cancle-base-recovery) 필요 (DB 전체를, 일관성 있는 백업본 시점으로)
</br>

6. Online
```SQL
alter database datafile 7 online;
```
---
</br>

#### ' 5. Recovery ' 時 Redo Log File 없는 경우, Cancel Base Recovery ( 불완전 복구 ) <a id="cancle-base-recovery"></a>
- Recovery 대상 Data 파일의 Redo Log File 없는 경우, 해당 Data File Offline Drop ( 미사용 ) OR DB 전체를 백업 시점으로 Rollback 中 선택 ( Recovery 대상 Data 파일만 Redo 적용 없이 DB Open 절대 불가 )
```SQL
recover database using backup controlfile until cancel;
```
> ' Specify log: {<RET>=suggested | filename | AUTO | CANCEL} ' 질문 時 ' cancel ' 입력 필수
- Recovery 대상 Data 파일의 Recovery 취소 ( ' 3. Recovery 필요 파일들만 Offline ' 상태 유지 )
</br>

```SQL
alter database open resetlogs; /* 불완전 복구시, DB Open 필수 문법 */
```
> Redo Log File 새로 생성, ' SEQUENCE# ' 1부터 새로 시작
---
