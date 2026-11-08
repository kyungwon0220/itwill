alter database begin backup;
alter database end backup;
alter database backup controlfile to '/home/oracle/backup/26110821/control01.ctl';
alter database backup controlfile to trace as '/home/oracle/backup/26110821/control_trace.txt';
alter system archive log current;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--11	/u01/app/oracle/oradata/ORA19C/redo02.log	200	1	NO	CURRENT	    2596274	2026-11-06 08:08:30	18446744073709551615	
--10	/u01/app/oracle/oradata/ORA19C/redo01.log	200	1	YES	ACTIVE	    2596205	2026-11-06 08:06:44	2596274	                2026-11-06 08:08:30
--9	    /u01/app/oracle/oradata/ORA19C/redo03.log	200	1	YES	INACTIVE	2594285	2026-11-06 08:02:14	2596205	                2026-11-06 08:06:44
    2	0	/u01/app/oracle/oradata/ORA19C/redo02.log	200	1	YES	UNUSED	0		0	
    1	1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	1	NO	CURRENT	2596377	    2026-11-06 09:20:23	18446744073709551615	
    3	0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	1	YES	UNUSED	0		0	




alter database add supplemental log data;
select supplemental_log_data_min from v$database;

begin
    dbms_logmnr.add_logfile(logfilename=>'/home/oracle/backup/arch1/arch_1_9_1248540249.arc', options=>dbms_logmnr.new);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo01.log', options=>dbms_logmnr.addfile);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo02.log', options=>dbms_logmnr.addfile);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log', options=>dbms_logmnr.addfile);
end;
/

exec dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);
select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss') time, operation, sql_redo, sql_undo, seg_owner from v$logmnr_contents where seg_owner = 'JAMES';
exec dbms_logmnr.end_logmnr;
--2026-11-06 08:33:02	DDL	drop table "JAMES"."EMP" cascade constraints purge force;		JAMES /* ' drop user james cascade; ' 실행시, 내부적으로 先 발생한 객체 삭제 */
--2026-11-06 08:33:03	DDL	drop user james cascade;		                                JAMES

drop user hr cascade;
drop user james cascade;
select count(*) from hr.employees;
select username, account_status, created from dba_users where username in ('HR', 'JAMES');




select * from dba_directories where directory_name = 'PUMP_DIR';

drop table system.SYS_EXPORT_SCHEMA_01 purge;
select owner_name, job_name, operation, job_mode, state from dba_datapump_jobs;
--SYSTEM	SYS_EXPORT_SCHEMA_01	EXPORT                        	SCHEMA                        	NOT RUNNING /* expdp 작업중 중단된 경우 */

show parameter shared_pool_size;




SELECT * FROM v$version;
--Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production	"Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
--Version 19.3.0.0.0"	Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production	0

drop table hr.job_history purge;
select count(*) from hr.job_history;
--impdp system/oracle directory=pump_dir dumpfile=12C_HR_JOB_HISTORY.DMP tables=hr.job_history remap_tablespace='EXAMPLE':'sysaux';




drop public database link win12c_link;
create public database link win12c_link connect to system identified by oracle using 'win12c'; /* DB Link 생성 */
select * from dba_db_links;
--SYS	SYS_HUB		SEEDDATA	2019/04/17 01:12:06	NO	NO	YES	NO
    SYS	    SYS_HUB		        SEEDDATA	2019/04/17 01:12:06	NO	NO	YES	NO
    PUBLIC	WIN12C_LINK	SYSTEM	win12c	    2026/11/06 13:06:37	NO	NO	YES	NO
    
select * from hr.job_history@win12c_link;

select username, account_status, created from dba_users where oracle_maintained = 'N';
--HR	    OPEN	2026/11/06 11:12:00
--JAMES	    OPEN	2026/11/06 04:28:08

select table_name from dba_tables where owner = 'JAMES';
--EMP
    EMP
    JOB_HISTORY

--impdp system/oracle network_link=win12c_link tables=hr.job_history exclude=trigger,grant,ref_constraint remap_schema='hr':'james' remap_tablespace='EXAMPLE':'sysaux' /* dmp File Export 과정을 생략하고, DB Link 통해서 JAMES 유저에게 즉시 Import */
