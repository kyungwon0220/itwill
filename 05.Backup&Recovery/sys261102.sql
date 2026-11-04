alter system set log_archive_dest_2="location=/home/oracle/backup/arch1/ mandatory" scope = spfile;
alter system set log_archive_dest_1="location=/home/oracle/backup/arch2/ optional" scope = spfile;
alter database archivelog;
alter database open;
shutdown immediate;
startup;
archive log list;

select destination, binding, status from v$archive_dest where destination is not null;
/home/oracle/backup/arch2/	MANDATORY	VALID
/home/oracle/backup/arch1/	OPTIONAL	VALID

alter system archive log current;
alter system switch logfile;
alter database datafile 7 offline;
recover datafile 7;
alter database datafile 7 online;
alter database clear unarchived logfile group 3; /* Redo Log File 손상 時 Mount 시점에서, 다른 Redo Log 파일을, 손상된 파일명으로 복제하고 Clear 작업시 DB Open 가능 */

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--3	3	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	INACTIVE	2327084	2026-11-01 12:05:35	2427128	2026-11-01 12:15:58
--2	5	/u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	CURRENT	    2442753	2026-11-04 21:17:13	18446744073709551615	
--1	4	/u01/app/oracle/oradata/ORA19C/redo01.log	200	YES	ACTIVE	    2427128	2026-11-01 12:15:58	2442753	2026-11-04 21:17:13
3	0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	2469639	2026-11-04 22:29:18	2469648	2026-11-04 22:29:39
2	17	/u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	CURRENT	2469651	2026-11-04 22:29:40	18446744073709551615	
1	16	/u01/app/oracle/oradata/ORA19C/redo01.log	200	YES	INACTIVE	2469648	2026-11-04 22:29:39	2469651	2026-11-04 22:29:40

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;
--3	SYSAUX	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2453504	ONLINE
--1	SYSTEM	/u01/app/oracle/oradata/ORA19C/system01.dbf	2453504	SYSTEM
--7	USERS	/u01/app/oracle/oradata/ORA19C/users01.dbf	2453504	ONLINE
--5	UNDO1	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2453504	ONLINE
    3	SYSAUX	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2453504	ONLINE
    1	SYSTEM	/u01/app/oracle/oradata/ORA19C/system01.dbf	2453504	SYSTEM
    7	USERS	/u01/app/oracle/oradata/ORA19C/users01.dbf	2453504	RECOVER
    5	UNDO1	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2453504	ONLINE
--3	SYSAUX	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2453504	ONLINE
--1	SYSTEM	/u01/app/oracle/oradata/ORA19C/system01.dbf	2453504	SYSTEM
--7	USERS	/u01/app/oracle/oradata/ORA19C/users01.dbf	2455535	ONLINE
--5	UNDO1	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2453504	ONLINE
