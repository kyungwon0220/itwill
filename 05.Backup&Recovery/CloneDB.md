### 하나의 Server 內 DB 복제 Step
1. 복제할 DB, Data 파일들과 Archive Backup Log File 복사 ( cp )
```CMD
cp /home/oracle/backup/*.dbf /home/oracle/backup/clone/
cp /home/oracle/backup/arch1/* /home/oracle/backup/clone/
```
</br>

2. [Text Parameter File](InitializationParameterFileAndParameter.md#text-parameter-file) 생성
```SQL
create pfile ='/home/oracle/backup/clone/initclone.ora' from spfile;
vim /home/oracle/backup/clone/initclone.ora
```
```TEXT
*.compatible='19.0.0'
*.control_files='/home/oracle/backup/clone/control01.ctl'
*.db_name='clone'
*.log_archive_dest_2='location=/home/oracle/backup/clone/ mandatory'
*.log_archive_format='arch_%t_%s_%r.arc'
*.undo_tablespace='UNDO1'
```
> 필수 내용으로 작성
</br>

3. [Control File 재생성](261007.md#control-file-remake) 작업
```SQL
alter database backup controlfile to trace as '/home/oracle/backup/clone/control_trace.txt';
```
```CMD
vim /home/oracle/backup/clone/control_trace.txt
```
```TEXT
STARTUP NOMOUNT
--120 CREATE CONTROLFILE REUSE DATABASE "ORA19C" RESETLOGS  ARCHIVELOG
120 CREATE CONTROLFILE SET DATABASE "CLONE" RESETLOGS  ARCHIVELOG
121     MAXLOGFILES 16
122     MAXLOGMEMBERS 3
123     MAXDATAFILES 100
124     MAXINSTANCES 8
125     MAXLOGHISTORY 292
126 LOGFILE
--127   GROUP 1 '/u01/app/oracle/oradata/ORA19C/redo01.log'  SIZE 200M BLOCKSIZE 512,
--128   GROUP 2 '/u01/app/oracle/oradata/ORA19C/redo02.log'  SIZE 200M BLOCKSIZE 512,
--129   GROUP 3 '/u01/app/oracle/oradata/ORA19C/redo03.log'  SIZE 200M BLOCKSIZE 512
127   GROUP 1 '/home/oracle/backup/clone/redo01.log'  SIZE 200M BLOCKSIZE 512
128   GROUP 2 '/home/oracle/backup/clone/redo02.log'  SIZE 200M BLOCKSIZE 512
129   GROUP 3 '/home/oracle/backup/clone/redo03.log'  SIZE 200M BLOCKSIZE 512
--130 STANDBY LOGFILE
131 DATAFILE
--132   '/u01/app/oracle/oradata/ORA19C/system01.dbf',
--133   '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf',
--134   '/u01/app/oracle/oradata/ORA19C/sysaux01.dbf',
--135   '/u01/app/oracle/oradata/ORA19C/undo01.dbf',
--136   '/u01/app/oracle/oradata/ORA19C/users01.dbf'
132   '/home/oracle/backup/clone/system01.dbf',
133   '/home/oracle/backup/clone/data_tbs01.dbf',
134   '/home/oracle/backup/clone/sysaux01.dbf',
135   '/home/oracle/backup/clone/undo01.dbf',
136   '/home/oracle/backup/clone/users01.dbf'
137 CHARACTER SET AL32UTF8
138 ;
```
> DB 복제 時 Redo 정보는 Archive Backup Log 파일로 적용 가능하기에, Control Trace File 내용 上 ' RESETLOGS ' Part, TEMPFILE Part 발췌
- 120 Line ' REUSE ' 문구를 ' SET ', ' ORA19C ' 문구를 ' CLONE ' 수정
  - 복제 DB 上 Control File 처음 생성하기에
- 127 Line 경로 수정 필수
- 130 ' STANDBY LOGFILE ' 부분 삭제 ( 공백 포함 )
- 132 Line 경로 수정 필수
```TEXT
148 RECOVER DATABASE USING BACKUP CONTROLFILE
151 ALTER DATABASE OPEN RESETLOGS;
156 ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/app/oracle/oradata/ORA19C/temp01.dbf' SIZE 33554432  REUSE AUTOEXTEND ON;
```

</br>

4. 
```CMD
echo $ORACLE_HOME
--/u01/app/oracle/product/19.3.0/dbhome_1


. oraenv
```
> ' ORACLE_SID = [ora19c] ? ' 질문 時 ' clone ' DB 名 입력
> ' ORACLE_HOME = [/home/oracle] ? ' 질문 時 ' /u01/app/oracle/product/19.3.0/dbhome_1 ' Oracle SW 설치된 경로 입력
</br>

5. 생성했던 pfile 기반으로, Nomount 시점까지 DB Open
```SQL
startup pfile = /home/oracle/backup/clone/initclone.ora nomount;


select instance_name, status from v$instance;
```
> 명령처럼 붙여넣기 성공하면, Mount 시점까지 Auto DB Open
</br>

6. [Cancel Base Recovery ( 불완전 복구 )](NoarchiveLogModeBackup.md#cancle-base-recovery) 後 DB Open
```SQL
recover database using backup controlfile until cancel;


alter database open resetlogs; /* 불완전 복구시, DB Open 필수 문법 */
```
> Archive Backup Log 파일로 Recovery 後 마지막 CURRENT Redo Archive File 없기에, ' cancel ' 입력
---
</br></br></br>

- ```CMD
  rm /home/oracle/backup/clone/*
  rm /u01/app/oracle/diag/rdbms/{DB 名}/*
  ```
  > 복제 DB 삭제
---
