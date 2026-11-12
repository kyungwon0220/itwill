### Archive Backup Log File 생성 경로 초기화
- Path 초기화시, ' $ORACLE_BASE/fast_recovery_area/{DB 名}/ ' Default 경로로 설정
  - Default 경로 설정이 안되어 있을시, ' /u01/app/oracle/product/19.3.0/dbhome_1/dbs/ ' 경로 ( $ORACLE_HOME/dbs )
```SQL
alter system set log_archive_dest_1='location=use_db_recovery_file_dest' scope=both;

ALTER SYSTEM RESET log_archive_dest_2 scope=both;
```
- ' /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/ ' == Archive Backup Log File 저장소
- ' /u01/app/oracle/fast_recovery_area/ORA19C/autobackup/ ' == Log Switch 동작 등으로, Control File, spfile 백업본 저장소
- ' /u01/app/oracle/fast_recovery_area/ORA19C/backupset/ ' == 백업할 Data File 內 Block 모아서 하나의 bkp 파일로 저장
- ' /u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/ ' == Redo Log File 저장소

</br></br></br>
```SQL
show parameter db_recovery_file_dest;
```
> 사용 공간이 85% Waring Alert 발생, 97% 도달하면 Critical Alert 발생 ( Alert Log )
|NAME|TYPE|VALUE|
:---|:---|:---|
db_recovery_file_dest|string|/u01/app/oracle/fast_recovery_area|
db_recovery_file_dest_size|big integer|8256M|
---
</br></br></br>

## RMAN ( Recovery Manager )
- SELECT 사용 가능
- 결과 출력 Column 열 폭 조절 불가
- OS 內 RMAN 접속
  ```CMD
  rman target /
  ```
  ```CMD
  rman auxiliary /
  ```
  > Nomount 시점에서, RMAN 접속 ( DB 복제 등의 경우 )
- ```
  show all;
  ```
  ```TEXT
  RMAN configuration parameters for database with db_unique_name ORA19C are:
  CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default
  CONFIGURE BACKUP OPTIMIZATION OFF; # default
  CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default
  CONFIGURE CONTROLFILE AUTOBACKUP ON; # default
  CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
  CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
  CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
  CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
  CONFIGURE MAXSETSIZE TO UNLIMITED; # default
  CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
  CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default
  CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default
  CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
  CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default
  CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/u01/app/oracle/product/19.3.0/dbhome_1/dbs/snapcf_ora19c.f'; # default
  ```
  - ' CONFIGURE CONTROLFILE AUTOBACKUP ON; # default ' == Control File Auto Backup
    - ```
      CONFIGURE CONTROLFILE AUTOBACKUP OFF;
      ```
      > Control Auto Bakcup 아닌, 수동 Backup
  - ' CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default ' == Control File Auto Backup 時 파일명 Format
    - ```
      CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/home/oracle/backup/rman/clone/%F';
      ```
      - ' %F ' == c-{DBID}-YYYYMMDD-QQ
        - DBID == ' v$database ' 內 ' DBID '
        - QQ == 00 ~ 16진수 FF, Sequence Value
    - ```
      CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK CLEAR;
      ```
      > 초기화 예제 코드
  - ' CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default ' == 미설정시 ( /u01/app/oracle/product/19.3.0/dbhome_1/dbs/ 경로에 ( $ORACLE_HOME/dbs ) 생성 )
    - ```
      CONFIGURE CHANNEL DEVICE TYPE DISK CLEAR;
      ```
      > 초기화 예제 코드
    - ```
      CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/home/oracle/backup/rman/clone/%U_%T';
      ```
      - ' %U '
        - ' %u ' == ' BS Key', 생성 시각을 조합해 만든 8자리 고유 문자열
        - ' %p ' == Backupset 내부상 Backup Piece 번째 수
        - ' %c ' == 중복 Backup 時 백업본 Number ( ' 1 ' Default )
      - ' %T ' == Backup Date ( 예를 들면, 20261112 )
- ```
  report schema;
  --select file_id, tablespace_name, file_name, bytes/1024/1024 mb from dba_data_files;
  --select file_id, tablespace_name, file_name, bytes/1024/1024 mb from dba_temp_files;
  ```
  > RMAN 재접속시, 손상 File 재감지
  - ' RB segs ' == Undo Segment ( ' Rollback Segment ' 동의어 ) 생성 여부
- ```
  list archivelog all;

  list archivelog from scn 4199492;

  list archivelog from scn 4199492 until scn 4212424;

  list archivelog from sequence 5;

  alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';
  list archivelog from time '2026-11-12 16:05:00';

  --select sequence#, name, first_change#, to_char(first_time, 'yyyy-mm-dd hh24:mi:ss') first_name, next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
  --from v$archived_log
  --where next_change# >= 4199492;


  alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';
  list archivelog until time '2026-11-12 16:05:00';
  ```
  > 특정 SCN 이후에 생성된 Archive Backup Log File 조회 예제 코드
- ```
  list failure;


  list failure 82 detail;
  ```
  > 복구 필요 대상

- ```
  --select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') backup_time
  --from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
  --where a.file# = b.file#;
  list backup;


  list backup of datafile 4;


  list backup of tablespace data_tbs;


  list backup of datafile '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf';


  alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';
  list backup completed before '2026-11-12 16:05:00';


  alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';
  list backup completed after '2026-11-12 16:05:00';
  ```
  > 특정 Data File 및 Tablespace Level 백업본 조회 예제 코드
  - ```
    report need backup;
    ```
    > Backup 필요 대상
- ```
  backup database;
  ```
  > DB Level Backup ( Alert Log 미기재 )
- ```
  backup tablespace data_tbs;
  ```
  > Tablespace Level Backup
- ```
  backup datafile 4;
  ```
  > 하나의 Data File Backup ( Alert Log 미기재 )
- ```
  delete backupset 11;
  ```
  > ' list backup; ' 실행하여, 불필요한 백업본 ' BS Key ' 지정 삭제 가능
- ```
  report obsolete;


  --DELETE OBSOLETE;
  ```
  > 오라클은 보존 정책(Retention Policy)을 기준으로, 필요 없는 파일들 조회
  - 실제 OS 上 물리적인 File 없어도, Control 파일에 기록된 백업본이 출력된다면 Cross Check 필요
    ```
    crosscheck backup;

    
    crosscheck archivelog all;
    ```
    > 물리적으로 존재하지 않는 파일들은, 내부적으로 ' EXPIRED ' 처리
    - ' EXPIRED ' 처리된 목록 삭제 가능
      ```
      --list expired backupset;
      --list expired archivelog all;
      

      delete expired backupset;
      delete expired archivelog all;
      ```
      > ' EXPIRED ' 처리된 목록 삭제
- ```
  --restore controlfile from ''/
  restore controlfile from autobackup;
  ```
  > Control File 재생성 후에는, Temp File Add 필수 ( ' alter tablespace temp add tempfile '/u01/app/oracle/oradata/ORA19C/temp01.dbf' REUSE autoextend on; ' )

</br></br></br>
#### Data File 손상 時 RMAN 복구 Scenario
0. Data File 손상 後 RMAN 접속
   ```CMD
   rm /u01/app/oracle/oradata/ORA19C/data_tbs01.dbf


   rman target /
   ```
</br>

1. 손상된 Data File 조회
   ```
   report schema;
   list failure;
   list failure detail 2;
   list failure detail 82;
   ```
</br>

2. 손상된 Data File Offline
   ```
   alter database datafile 2 offline;
   ```
</br>

3. 손상된 Data File Restore
   ```
   restore datafile 2;
   ```
</br>

3. 손상된 Data File Recover ( Redo 적용 )
   ```
   recover datafile 2;
   ```
</br>

4. 손상된 Data File Online
   ```
   alter database datafile 2 online;
   ```
---
</br></br></br>
#### DB 운영 中 Redo Log File, Control File 손상 ( rm ) 時 RMAN 복구 Scenario
0. DB 운영 中 Redo Log File, Control File 손상 ( rm ) 가정
   ```CMD
   rm /home/oracle/backup/clone/redo0*
   rm /home/oracle/backup/clone/control01.ctl
   ```
   ```SQL
   shutdown abort;
   ```
   > DB 자동으로 Down 될테나, 종료가 안되었을시 강제 Down
   </br>

1. DB Nomount 시점까지 Open
</br>

2. RMAN 접속 後 Control File 백업본으로, Control File Restore
   ```CMD
   rman target /


   select status, instance_name from v$instance;


   restore controlfile from autobackup;
   ```
   > 성공시, Control File 백업본 생성
</br>

3. Mount 시점까지 DB Open 後 Restore 및 Recover 시도
   ```
   alter database mount;
   
   restore database;

   recover database;
   ```
   > DB 운영중에 Redo 손상으로, 사용중이던 Current Redo Log File 부재하여 적용 불가 ERR 및 SCN Check
</br>

4. Current Redo Log 시작점 SCN 까지 Recovery
   ```
   run {
    set until snc=4371520;
    restore database;
    recover database;
   }
   ```
   > 사용중이던 Curren Redo Log File 시작 SCN 4371520 이전까지만 범위 지정 Recovery ( RMAN 內 Cancel Base Recovery )
</br>

5. DB Open
   ```
   alter database open resetlogs;
   ```
   > Incarnation 분리ㄷ
---


</br></br></br>
```
/* 수동 복구시, Data File 경로 변경 Step
1. alter database datafile 4 offline;
2. Restore 작업 ( cp )
3. alter database rename file '{기존 경로}' to '{변경할 경로}';
4. recover datafile 4;
5. alter database datafile 4 online;
*/

/* RMAN 복구시, Data File 경로 변경 Step
1. alter database datafile 4 offline;
2. set newname for datafile 4 to {변경할 경로}; # restore 명령에 적용할 임시 설정값으로, ' run{} ' 작업형 모드에서만 사용 가능
3. restore datafile 4;
4. switch datafile 4; # == ' 3. alter database rename file  '{기존 경로}' to '{변경할 경로}'; '
5. recover datafile 4;
6. alter database datafile 4 online;
*/

run {
    alter database datafile 4 offline;
    set newname for datafile 4 to '/home/oracle/backup/data_tbs02.dbf';
    restore datafile 4;
    switch datafile 4;
    recover datafile 4;
    alter database datafile 4 online;
}
```
---
