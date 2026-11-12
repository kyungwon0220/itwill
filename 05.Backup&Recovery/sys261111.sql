select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--3	0	/home/oracle/backup/clone/redo03.log	200	1	YES	UNUSED	    0		0	
--2	2	/home/oracle/backup/clone/redo02.log	200	1	NO	CURRENT	    4502526	        2026-11-12 18:04:43	18446744073709551615	
--1	1	/home/oracle/backup/clone/redo01.log	200	1	YES	INACTIVE	4498575	        2026-11-12 17:12:45	4502526	2026-11-12 18:04:43
    3	3	/home/oracle/backup/clone/redo03.log	200	1	YES	ACTIVE	    4508620	2026-11-12 18:22:54	4509401	                2026-11-12 18:31:08
    2	2	/home/oracle/backup/clone/redo02.log	200	1	YES	INACTIVE	4502526	2026-11-12 18:04:43	4508620	                2026-11-12 18:22:54
    1	4	/home/oracle/backup/clone/redo01.log	200	1	NO	CURRENT	    4509401	2026-11-12 18:31:08	18446744073709551615	
--3	0	/home/oracle/backup/clone/redo03.log	200	1	YES	UNUSED	0		0	
--2	0	/home/oracle/backup/clone/redo02.log	200	1	YES	UNUSED	0		0	
--1	1	/home/oracle/backup/clone/redo01.log	200	1	NO	CURRENT	4508832	        2026-11-12 18:42:05	18446744073709551615	

run {
    set until sequence=2; /* SEQUENCE# ' 3' 이전까지 ( ' 2 ' 포함까지 ) Redo Log File 복구 범위 지정 */
    restore database;
    recover database;
} /* RMAN 內 Cancel Base Recovery */

alter database open resetlogs;

alter system archive log current;




alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';
run {
    set until time'2026-11-12 14:28:00';
    restore database;
    recover database;
} /* ' 2026-11-12T14:29:25.858138+09:00 ' 이전으로 */

list incarnation of database;




drop user hr cascade;
select count(*) from hr.employees;

begin
    dbms_logmnr.add_logfile(logfilename=>'/home/oracle/backup/clone/redo03.log', options=>dbms_logmnr.new);
end;
/
exec dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);
select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss') time, operation, sql_redo, sql_undo from v$logmnr_contents where seg_owner = 'HR';
--2026-11-12 18:28:12	DDL	drop trigger "HR"."UPDATE_JOB_HISTORY";	
--2026-11-12 18:28:12	DDL	drop trigger "HR"."SECURE_EMPLOYEES";	
--2026-11-12 18:28:12	DDL	drop sequence "HR"."LOCATIONS_SEQ";	
--2026-11-12 18:28:12	DDL	drop sequence "HR"."EMPLOYEES_SEQ";	
--2026-11-12 18:28:12	DDL	drop sequence "HR"."DEPARTMENTS_SEQ";	
--2026-11-12 18:28:12	DDL	drop view "HR"."EMP_DETAILS_VIEW" cascade constraints;	
--2026-11-12 18:28:12	DDL	drop table "HR"."JOB_HISTORY" cascade constraints purge force;	
--2026-11-12 18:28:12	DDL	drop table "HR"."JOBS" cascade constraints purge force;	
--2026-11-12 18:28:13	DDL	drop table "HR"."REGIONS" cascade constraints purge force;	
--2026-11-12 18:28:13	DDL	drop table "HR"."LOCATIONS" cascade constraints purge force;	
--2026-11-12 18:28:13	DDL	drop table "HR"."EMPLOYEES" cascade constraints purge force;	
--2026-11-12 18:28:13	DDL	drop table "HR"."DEPARTMENTS" cascade constraints purge force;	
--2026-11-12 18:28:13	DDL	drop table "HR"."COUNTRIES" cascade constraints purge force;	
--2026-11-12 18:28:13	DDL	drop procedure "HR"."SECURE_DML";	
--2026-11-12 18:28:13	DDL	drop procedure "HR"."ADD_JOB_HISTORY";	
--2026-11-12 18:28:14	DDL	drop user hr cascade;	
exec dbms_logmnr.end_logmnr;

run {
    startup pfile=/home/oracle/backup/clone/initclone.ora nomount;
    restore controlfile from '/u01/app/oracle/product/19.3.0/dbhome_1/dbs/c-1447938829-20261112-07';
    alter database mount;
    alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';
    set until time '2026-11-12 18:27:00';
    restore database;
    recover database;
    alter database open resetlogs;
}




--rman auxiliary /

run {
    set newname for datafile 1 to '/home/oracle/backup/clone2/system01.dbf';
    set newname for datafile 5 to '/home/oracle/backup/clone2/undotbs01.dbf';
    set newname for datafile 3 to '/home/oracle/backup/clone2/sysaux01.dbf';
    set newname for datafile 2 to '/home/oracle/backup/clone2/data_tbs01.dbf';
    set newname for datafile 7 to '/home/oracle/backup/clone2/users01.dbf';
    set newname for tempfile 1 to '/home/oracle/backup/clone2/temp01.dbf';
    duplicate target database to 'clone2'
    pfile='/home/oracle/backup/clone2/initclone2.ora'
    nofilenamecheck
    backup location '/home/oracle/backup/clone2'
    until time "to_date('2026-11-12 18:27:30', 'yyyy-mm-dd hh24:mi:ss')"
    logfile
        '/home/oracle/backup/clone2/redo01.log' size 50m,
        '/home/oracle/backup/clone2/redo02.log' size 50m,
        '/home/oracle/backup/clone2/redo03.log' size 50m;
}
