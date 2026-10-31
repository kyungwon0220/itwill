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


### 현재 DB Checkpoint 조회
```SQL
select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 */
```
---
</br></br></br>


### Data File Checkpoint 조회
```SQL
select file#, name, status, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile;
```
---
</br></br></br>


### 현재 Redo 정보 조회
```SQL
select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;
```
|GROUP#|SEQUENCE#|MEMBER|MB|ARCHIVED|STATUS|RIRST_CHANGE#|NEXT_CHANGE#|NEXT_CHANGE#|
---:|---:|:---|---:|:---|:---|---:|---:|
2|6|/u01/app/oracle/oradata/ORA19C/redo02.log|200|NO|INACTIVE|2135883|2236839
1|7|/u01/app/oracle/oradata/ORA19C/redo01.log|200|NO|CURRENT|2236839|18446744073709551615|
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
