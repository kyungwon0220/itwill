### 현재 DB Open 시점 조회
```SQL
select status from v$instance;
```
|STATUS|
|:---|
MOUNTED|
---
</br></br></br>


### Recover 대상 File 조회 <a id="sql-select_recover_file"></a>
```SQL
select * from v$recover_file;
```
|FILE#|ONLINE|ONLINE_STATUS|ERROR|CHANGE#|TIME|CON_ID|
---:|:---|:---|:---|---:|:---|---:|
7|ONLINE|ONLINE|FILE NOT FOUND|0|(NULL)|0|
---
</br></br></br>


### Control 파일이 갖고있는, Data File 정보
```SQL
select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;
```
|FILE#|TBS_NAME|FILE_NAME|CHECKPOINT_CHANGE#|STATUS|
---:|:---|:---|---:|:---|
1|SYSTEM|/u01/app/oracle/oradata/ORA19C/system01.dbf|3200050|SYSTEM|
---
</br></br></br>


### Control 파일이 갖고있는, Data File Backup 정보
```SQL
select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') backup_time
from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
where a.file# = b.file#;
```
- ' CHANGE# ' == 백업시 Checkpoint 시점
- ' TIME ' == 백업 시각
- ' BACKUP_TIME ' == ' 0 ' == Online Backup 이력 없다는 의미
---
</br></br></br>


### 현재 DB Checkpoint 조회
```SQL
select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 */
```
|NAME|LOG_MODE|CHECKPOINT_CHANGE#|SCN_TO_TIMESTAMP(CHECKPOINT_CHANGE#)|CURRENT_SCN|
:---|:---|:---|---:|---:|
ORA19C|NOARCHIVELOG|2236840|26/10/31 04:13:33.000000000|2285811|
- CHECKPOINT_CHANGE# : 마지막에 발생한, Check Point SCN ( Dirty 버퍼를 Write 작업한, 마지막 시점 )
- SCN_TO_TIMESTAMP(CHECKPOINT_CHANGE#) : ' CHECKPOINT_CHANGE# ' 발생 시각
- CURRENT_SCN : 현재 SCN
---
</br></br></br>


### Data File Checkpoint 조회
```SQL
select file#, name, status, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile; /* Control File 내용이며, ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 */
```
---
</br></br></br>


### 현재 Redo 정보 조회
```SQL
select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
```
|GROUP#|SEQUENCE#|MEMBER|MB|MEMBER|ARCHIVED|STATUS|FIRST_CHANGE#|FIRST_TIME|NEXT_CHANGE#|NEXT_TIME|
---:|---:|:---|---:|---:|:---|:---|---:|:---|---:|:---|
2|6|/u01/app/oracle/oradata/ORA19C/redo02.log|200|1|NO|INACTIVE|2135883|2026-11-01 16:03:22|2236839|2026-11-01 16:08:07|
1|7|/u01/app/oracle/oradata/ORA19C/redo01.log|200|1|NO|CURRENT|2236839|2026-11-01 16:08:07|18446744073709551615|(null)|
---
</br></br></br>


### 특정 세그먼트가, 어느 Data 파일에 있는지 조회
```SQL
select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP' /* 대문자 입력 필수 */
and e.owner = 'HR'; /* 대문자 입력 필수 */
```
|FILE_NAME|
:---|
/u01/app/oracle/oradata/ORA19C/users01.dbf|
---
</br></br></br>


### 특정 세그먼트의 Extent 수 조회 ( Data 파일별 )
```SQL
select f.tablespace_name, f.file_name, count(*)
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP' /* 대문자 입력 필수 */
and e.owner = 'HR' /* 대문자 입력 필수 */
group by f.tablespace_name, f.file_name;
```
|TABLESPACE_NAME|FILE_NAME|COUNT(*)|
:---|:---|---:|
USERS|/u01/app/oracle/oradata/ORA19C/users01.dbf|1|
---
