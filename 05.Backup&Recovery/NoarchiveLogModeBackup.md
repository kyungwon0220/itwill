# Noarchive Log Mode Backup
- Redo 정보가 없으면, 백업 시점 이후의 작업 내용은 복구 불가 ( 백업 시점으로의 복구만 가능 )
  - 백업본 이후의 Redo 정보 존재시, 완전 복구 가능
- DB 정상 종료 後 Whole(Full) Backup 진행 ( shutdown { NORMAL || TRANSACTIONAL || IMMEDIATE} )
  - 필수 Backup 대상 : 모든 Data File, Control File, Temp File
  - 선택적 Backup 대상 : Redo Log File, 초기 파라미터 File, 패스워드 File, Temp File
- 일관성 있는 Backup ( Close Backup = Cold Backup = Offline Backup ) : 모든 Data 파일의 Checkpoint, Control 파일의 Checkpoint, Redo Checkpoint 정보가 일치하는 Backup
```SQL
select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database;
```
|NAME|LOG_MODE|CHECKPOINT_CHANGE#|SCN_TO_TIMESTAMP(CHECKPOINT_CHANGE#)|CURRENT_SCN|
:---|:---|:---|---:|---:|
ORA19C|NOARCHIVELOG|2236840|26/10/31 04:13:33.000000000|2285811|
- CHECKPOINT_CHANGE# : 마지막에 발생한, Check Point SCN ( Dirty 버퍼를 Write 작업한, 마지막 시점 )
- SCN_TO_TIMESTAMP(CHECKPOINT_CHANGE#) : ' CHECKPOINT_CHANGE# ' 발생 시각
- CURRENT_SCN : 현재 SCN
</br></br></br>
## Step
0. 일지 작성 준비
```SQL
select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 */
select name, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile; /* 파일별 Checkpoint 시점과, 발생한 시각 */
```
2. DB 정상 종료
```SQL
shutdown immediate;
```
> shutdown { NORMAL || TRANSACTIONAL || IMMEDIATE}
2. OS 內 대상 File 복사 ( cp )
```CMD
cp -v /u01/app/oracle/oradata/ORA19C/* /home/oracle/backup/noarch/
```
3. DB Open
4. pfile 백업본 생성
```SQL
create pfile='/home/oracle/backup/noarch/initora19c.ora' from spfile;
```
6. Backup 일지 작성
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
> 백업 위치 정보
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
</br>

3. Recovery 필요 파일들만 Offline 後 DB Open 後 상황을, 전체 공지
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

5. Recovery
```SQL
recover tablespace users;
--recover datafile 7
```
> Restore 가져온 백업본 Checkpoint 시점부터의 Redo Log 정보 없을시, [불완전 복구](#cancle-base-recovery) 필요 (DB 전체를, 일관성 있는 백업본 시점으로)
</br>

6. Online
```SQL
alter database datafile 7 online;
```
---
</br></br></br>


#### ' 5. Recovery ' 時 Redo Log File 없는 경우, Cancel Base Recovery <a id="cancle-base-recovery"></a>
- Control 파일은, Redo Log 정보를 갖고 있다. 실제 Redo Log File 없는경우
```SQL
recover database using backup controlfile until cancel;
```
> ' Specify log: {<RET>=suggested | filename | AUTO | CANCEL} ' 질문 時 ' cancel ' 입력 필수
</br>

```SQL
alter database open resetlogs; /* 불완전 복구시, DB Open */
```
> Redo Log File 새로 생성, ' SEQUENCE# ' 1부터 새로 시작
---
