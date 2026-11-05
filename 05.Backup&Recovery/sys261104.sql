create tablespace data_tbs datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' size 5m;
create table hr.data_emp(id number) tablespace data_tbs;
insert into hr.data_emp values(4);
select * from hr.data_emp;
commit;
drop tablespace data_tbs including contents and datafiles;

alter database begin backup;
alter database end backup;
alter database backup controlfile to '/home/oracle/backup/26110601/control01.ctl';
alter database backup controlfile to trace as '/home/oracle/backup/26110601/control_trace.txt';
alter system archive log current;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2494081	SYSTEM
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2494081	ONLINE
--5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	    2494081	ONLINE
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2494081	ONLINE
--2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2494081	ONLINE
    1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2494940	SYSTEM
    3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2494940	ONLINE
    5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	    2494940	ONLINE
    7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2494940	ONLINE
    2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	2494940	ONLINE

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	2494078	2026-11-05 13:29:32	18446744073709551615	
--0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
--0	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	UNUSED	0		0	
    1	1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	YES	ACTIVE	2494078	2026-11-05 13:29:32	2495030	                2026-11-05 13:35:44
    3	0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
    2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	CURRENT	2495030	2026-11-05 13:35:44	18446744073709551615
--1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	YES	ACTIVE	2494078	2026-11-05 13:29:32	2495030	                2026-11-05 13:35:44
--0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
--2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	CURRENT	2495030	2026-11-05 13:35:44	18446744073709551615	
    2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	1	YES	INACTIVE	2495030	2026-11-05 13:35:44	2496662	                2026-11-05 14:44:12
    1	1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	2	YES	INACTIVE	2494078	2026-11-05 13:29:32	2495030	                2026-11-05 13:35:44
    3	3	/u01/app/oracle/oradata/ORA19C/redo03.log	200	1	NO	CURRENT	    2496662	2026-11-05 14:44:12	18446744073709551615	
    1	1	/home/oracle/backup/redo01.log	            200	2	YES	INACTIVE	2494078	2026-11-05 13:29:32	2495030	                2026-11-05 13:35:44

select * from v$tempfile;
--2498709	2026/11/05 15:01:52	3	1	ONLINE	READ WRITE	33554432	4096	33554432	8192	/u01/app/oracle/oradata/ORA19C/temp01.dbf	0




select * from database_properties;
alter database default tablespace data_tbs; /* User 생성 時 Default Tablespace 미지정시의, Default Tablespace */
drop tablespace data_tbs including contents and datafiles;




alter database add logfile member '/home/oracle/backup/redo01.log' to group 1;
alter  system switch logfile;
alter system checkpoint;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#;
--3	3	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	INACTIVE	2771528	2026-11-03 05:36:58	2771535	2026-11-03 05:37:13
--2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	INACTIVE	2771515	2026-11-03 05:36:37	2771528	2026-11-03 05:36:58
--1	4	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	    2771535	2026-11-03 05:37:13	18446744073709551615	
    3	0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
    2	0	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	UNUSED	0		0	
    1	1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	2800530	2026-11-03 00:39:37	18446744073709551615
--3	0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0		0	
--2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	CURRENT	2805698	2026-11-04 16:18:56	18446744073709551615	
--1	1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	YES	ACTIVE	2800530	2026-11-03 00:39:37	2805698	2026-11-04 16:18:56




select supplemental_log_data_min from v$database;
alter database add supplemental log data;




create table hr.itwill(id number, name varchar2(30)) tablespace users;
insert into hr.itwill(id, name) values(1, 'oracle');
update hr.itwill set name = 'james' where id = 1;
alter system switch logfile;
select * from hr.itwill;
drop table hr.itwill purge;
commit;

begin
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo01.log', options=>dbms_logmnr.new); /* ' .new ' == 분석할 Redo Log File 처음 등록시 */
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo02.log', options=>dbms_logmnr.addfile); /* ' .addfile ' == 분석할 Redo Log File 추가로 등록시 */
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log', options=>dbms_logmnr.addfile);
--    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_04/o1_mf_1_1_ogoq30wg_.arc', options=>dbms_logmnr.addfile); /* 내용이 동일한 Redo Log File 중복 등록시 ERR */
end;
/

select filename from v$logmnr_logs;
exec dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);
select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss') time, operation, sql_redo, sql_undo from v$logmnr_contents where seg_name = 'ITWILL'; /* Table Drop 時 insert Log 기록 안뜨 */
exec dbms_logmnr.end_logmnr;
