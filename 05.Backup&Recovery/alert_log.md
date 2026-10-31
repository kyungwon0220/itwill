### DB 정상 종료
```SQL
> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
```

```CMD
2026-10-31T23:48:25.226303+09:00
Shutting down ORACLE instance (immediate) (OS id: 23508)
2026-10-31T23:48:28.071267+09:00
Stopping background process SMCO
2026-10-31T23:48:29.097988+09:00
Shutting down instance: further logons disabled
2026-10-31T23:48:29.120323+09:00
Stopping background process CJQ0
Stopping background process MMNL
2026-10-31T23:48:29.299903+09:00
Process termination requested for pid 23740 [source = rdbms], [info = 2] [request issued by pid: 23734, uid: 1000]
2026-10-31T23:48:30.240974+09:00
Stopping background process MMON
2026-10-31T23:48:32.305450+09:00
License high water mark = 3
2026-10-31T23:48:32.381138+09:00
Dispatchers and shared servers shutdown

Data Pump shutdown on PDB: 0 in progress
2026-10-31T23:48:32.382691+09:00
Process termination requested for pid 24420 [source = rdbms], [info = 2] [request issued by pid: 23508, uid: 1000]
2026-10-31T23:48:34.465042+09:00
ALTER DATABASE CLOSE NORMAL
2026-10-31T23:48:34.498356+09:00
Stopping Emon pool
2026-10-31T23:48:35.501277+09:00

IM on ADG: Start of Empty Journal

IM on ADG: End of Empty Journal
Stopping Emon pool
stopping change tracking
2026-10-31T23:48:35.682494+09:00
Shutting down archive processes
2026-10-31T23:48:35.682859+09:00
TT00 (PID:23510): Gap Manager exiting
2026-10-31T23:48:36.697245+09:00
Archiving is disabled
2026-10-31T23:48:36.697832+09:00
Thread 1 closed at log sequence 7
Successful close of redo thread 1
2026-10-31T23:48:36.706628+09:00
Buffer Cache invalidation for all PDBs started
Buffer Cache invalidation for all PDBs complete
Completed: ALTER DATABASE CLOSE NORMAL
ALTER DATABASE DISMOUNT
Shutting down archive processes
Archiving is disabled
Completed: ALTER DATABASE DISMOUNT
.... (PID:23508): Archival disabled due to shutdown: 1089
Shutting down archive processes
Archiving is disabled
2026-10-31T23:48:37.877911+09:00
JIT: pid 23508 requesting stop
.... (PID:23508): Archival disabled due to shutdown: 1089
Shutting down archive processes
Archiving is disabled
JIT: pid 23508 requesting stop
2026-10-31T23:48:37.920009+09:00
Stopping background process VKTM
2026-10-31T23:48:52.609095+09:00
Instance shutdown complete (OS id: 23508)
```
---
</br></br></br>


### 하나의 Data File 손상 後 DB startup 時
```SQL
> startup
ORACLE instance started.

Total System Global Area 1241513488 bytes
Fixed Size                  8896016 bytes
Variable Size             318767104 bytes
Database Buffers          905969664 bytes
Redo Buffers                7880704 bytes
Database mounted.
ORA-01157: cannot identify/lock data file 7 - see DBWR trace file
ORA-01110: data file 7: '/u01/app/oracle/oradata/ORA19C/users01.dbf'
```
> OS 上 문제 File 하나만 출력 ( 문제되는 모든 파일은, Log 보거나 [v$recover_file](UsefulSQL.md#sql-select_recover_file) 조회 필요 )
---
