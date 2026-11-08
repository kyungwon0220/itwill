```TEXT
STARTUP NOMOUNT
CREATE CONTROLFILE REUSE DATABASE "ORA19C" NORESETLOGS  ARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 100
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '/u01/app/oracle/oradata/ORA19C/redo01.log'  SIZE 200M BLOCKSIZE 512,
  GROUP 2 '/u01/app/oracle/oradata/ORA19C/redo02.log'  SIZE 200M BLOCKSIZE 512,
  GROUP 3 '/u01/app/oracle/oradata/ORA19C/redo03.log'  SIZE 200M BLOCKSIZE 512
DATAFILE
  '/u01/app/oracle/oradata/ORA19C/system01.dbf',
  '/u01/app/oracle/oradata/ORA19C/sysaux01.dbf',
  '/u01/app/oracle/oradata/ORA19C/undo01.dbf',
  '/u01/app/oracle/oradata/ORA19C/users01.dbf'
CHARACTER SET AL32UTF8
;


ALTER TABLESPACE TEMP ADD TEMPFILE '/u01/app/oracle/oradata/ORA19C/temp01.dbf' SIZE 33554432  REUSE AUTOEXTEND ON NEXT 655360  MAXSIZE 32767M;
```
---
</br></br></br>


```TEXT
STARTUP NOMOUNT
CREATE CONTROLFILE SET DATABASE "CLONE" RESETLOGS  ARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 100
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '/home/oracle/backup/clone/redo01.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 2 '/home/oracle/backup/clone/redo02.log'  SIZE 50M BLOCKSIZE 512,
  GROUP 3 '/home/oracle/backup/clone/redo03.log'  SIZE 50M BLOCKSIZE 512
DATAFILE
  '/home/oracle/backup/clone/system01.dbf',
  '/home/oracle/backup/clone/data_tbs01.dbf',
  '/home/oracle/backup/clone/sysaux01.dbf',
  '/home/oracle/backup/clone/undo01.dbf',
  '/home/oracle/backup/clone/users01.dbf'
CHARACTER SET AL32UTF8
;


ALTER TABLESPACE TEMP ADD TEMPFILE '/home/oracle/backup/clone/temp01.dbf' SIZE 33554432 REUSE AUTOEXTEND ON;
```
> DB 복제시, Control File 처음 생성
---
