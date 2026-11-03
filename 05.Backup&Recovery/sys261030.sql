create tablespace data_tbs datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' size 5m;
create table hr.data_emp(id number) tablespace data_tbs;
insert into hr.data_emp values(5);
commit;

/* OS 內 /u01/app/oracle/oradata/ORA19C/data_tbs01.dbf 손상 ( rm ) */

select * from hr.data_emp; /* Data File 손상 前 작업중이었다면, Dirty Buffer Cache 內 Buffer 내용 정상 출력 */
    5
create table hr.data_emp2 tablespace data_tbs as select * from hr.employees; /* CTAS == Direct Write (Data File 직접 Access 필요) 방식으로, ERR 발생 */

alter database datafile 2 offline;
alter database create datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' as '/home/oracle/backup/tmp/test_tbs01.dbf';
alter database datafile 2 online;

alter tablespace data_tbs begin backup; /* data_tbs01.dbf Online Backup */
alter tablespace data_tbs end backup;
alter system archive log current;

alter database backup controlfile to '/home/oracle/backup/tmp/control_data_tbs.ctl';
alter database backup controlfile to trace as '/home/oracle/backup/tmp/control_trace_data_tbs.txt';

insert into hr.data_emp values(6);
commit;

/* OS 內 /home/oracle/backup/tmp/test_tbs01.dbf 손상 ( rm ) */

alter database datafile 2 offline; /* Data File Level 오프라인시, Ttablespace 內 모든 Data File ' RECOVER ' ( 그러므로, Tablespace Level Offline 권장 )*/
alter database rename file '/home/oracle/backup/tmp/test_tbs01.dbf' to '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf';
recover datafile 2;
alter database datafile 2 online;


alter tablespace data_tbs add datafile '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf' size 5m;
create table hr.emp2 tablespace data_tbs as select * from hr.employees;
insert into hr.emp2 select * from hr.emp2;
select count(*) from hr.emp2;
commit;

alter tablespace data_tbs begin backup; /* data_tbs02.dbf Online Backup */
alter tablespace data_tbs end backup;

/* OS 內 /home/oracle/backup/tmp/test_tbs02.dbf 손상 ( rm ) */

alter tablespace data_tbs offline immediate; /* Checkpoint 미발생 後 Offline */
recover tablespace data_tbs;
alter tablespace data_tbs online;

/* OS 內 /home/oracle/backup/tmp/test_tbs02.dbf 손상 ( rm ) */

alter tablespace data_tbs offline temporary;
alter database create datafile '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf';
recover tablespace data_tbs;
alter tablespace data_tbs online;

insert into hr.emp2 select * from hr.emp2;
select count(*) from hr.emp2;
rollback;

drop table hr.emp2 purge;
ALTER TABLESPACE DATA_TBS DROP DATAFILE '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf';


select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#; /* Control 파일이 갖고있는, Data File 정보 */
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2477831	ONLINE
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2477831	SYSTEM
--2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2501505	ONLINE
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2477831	ONLINE
--5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	    2477831	ONLINE
    3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2477831	ONLINE
    1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	2477831	SYSTEM
    2	DATA_TBS	/home/oracle/backup/tmp/test_tbs01.dbf	    2501505	RECOVER
    7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	2477831	ONLINE
    5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	2477831	ONLINE
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2705395	ONLINE
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2705395	SYSTEM
--2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2705395	ONLINE
--4	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2706305	ONLINE
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2705395	ONLINE
--5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	    2705395	ONLINE
    3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2705395	ONLINE
    1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2705395	SYSTEM
    2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2707867 /* 같은 테이블스페이스라, ' checkpoint_change# ' 갱신 ( data_tbs01.dbf 백업시, ' 2707867 ' 참고 금지 주의 )*/	ONLINE
    4	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2707867	ONLINE /* data_tbs02.dbf Online Backup */
    7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2705395	ONLINE
    5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	    2705395	ONLINE
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2705395	ONLINE
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	2705395	SYSTEM
--2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2708782	OFFLINE
--4	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2708782	OFFLINE /* 손상된 ' data_tbs02.dbf ' 파일만 OS 上 Restroe ( cp ) */
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	2705395	ONLINE
--5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	2705395	ONLINE    
    3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2705395	ONLINE
    1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	2705395	SYSTEM
    2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2708843	ONLINE
    4	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2708843	ONLINE
    8	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs03.dbf	2711978	ONLINE
    7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	2705395	ONLINE
    5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	2705395	ONLINE
    
select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') backup_time
from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
where a.file# = b.file#;
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
--2	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2501505	NOT ACTIVE	0	
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
--5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	    2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
    1	/u01/app/oracle/oradata/ORA19C/system01.dbf	2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
    2	/home/oracle/backup/tmp/test_tbs01.dbf	    2504933	ACTIVE	    2504933	2026-11-04 01:13:21
    3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
    5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
    7	/u01/app/oracle/oradata/ORA19C/users01.dbf	2477831	NOT ACTIVE	2442594	2026-11-01 15:21:50
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--2	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2705395	NOT ACTIVE	2504933	2026-11-04 01:13:21
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--4	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2706305	NOT ACTIVE	0	
--5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
    1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
    2	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2707867	NOT ACTIVE	2707867	2026-11-04 01:40:58
    3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
    4	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2707867	NOT ACTIVE	2707867	2026-11-04 01:40:58
    5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
    7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--2	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2708843	NOT ACTIVE	2707867	2026-11-04 01:40:58
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--4	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2708843	NOT ACTIVE	2707867	2026-11-04 01:40:58
--5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    2705395	NOT ACTIVE	2442594	2026-11-01 15:21:50
--8	/u01/app/oracle/oradata/ORA19C/data_tbs03.dbf	2711978	NOT ACTIVE	0	

select f.tablespace_name, f.file_name, count(*)
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP2' /* 대문자 입력 필수 */
and e.owner = 'HR' /* 대문자 입력 필수 */
group by f.tablespace_name, f.file_name;
--DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	10
    DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	16
    DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	1
--DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	16
--DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	2
    DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	18
    DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs03.dbf	2
    DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	4
