alter system set control_files = '/u01/app/oracle/oradata/ORA19C/control01.ctl' scope=spfile;
show parameter control_files;

alter system archive log current;

select * from v$tempfile;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
--0	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	UNUSED	0		0	
--1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	2469640	    2026-11-04 23:28:37	18446744073709551615	
    3	0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
    2	0	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	UNUSED	0		0	
    1	1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	2469640	    2026-11-04 23:28:37	18446744073709551615	
