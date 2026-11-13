select * from dba_datapump_jobs;

drop user hr cascade;

--@/home/oracle/data_pump/hr_schema.txt

select * from dba_users where username='HR';
select count(*) from hr.departments;




archive log list;
show parameter db_recovery_file_dest;
show parameter log_archive_dest_2;

alter system set log_archive_dest_1='location=use_db_recovery_file_dest' scope=both;
ALTER SYSTEM RESET log_archive_dest_2 scope=both;

alter system archive log current;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--1	YES	INACTIVE	4194988	2026-11-10 03:30:13	4196153	                2026-11-10 03:39:19
--1	NO	CURRENT	    4196173	2026-11-10 03:39:28	18446744073709551615	
--1	YES	INACTIVE	4196153	2026-11-10 03:39:19	4196173	                2026-11-10 03:39:28

show parameter db_recovery_file_dest; /* 사용 공간이 85% Waring alert 발생, 97% 도달하면 Critical alert 발생(alert log) */



select * from dba_datapump_jobs;
select * from dba_users where username='HR';
drop user hr cascade;





select dbid, name, log_mode from v$database;
    1301250928 ORA19C    ARCHIVELOG
select file_id, tablespace_name, file_name, bytes/1024/1024 mb from dba_data_files;
select file_id, tablespace_name, file_name, bytes/1024/1024 mb from dba_temp_files;

--rman target / /* OS 內 OS 인증 방식으로 RMAN 접속 */
--report schema;




select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') backup_time
from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
where a.file# = b.file#;
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
--2	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
--5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
    1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
    2	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
    3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
    4	/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf	4209040	NOT ACTIVE	0	
    5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45
    7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    4208728	NOT ACTIVE	4194880	2026-11-10 03:26:45

--list backup;




select * from hr.data_emp;
select f.tablespace_name, f.file_name, count(*)
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'DATA_EMP' /* 대문자 입력 필수 */
and e.owner = 'HR' /* 대문자 입력 필수 */
group by f.tablespace_name, f.file_name;




list archivelog all;
alter system archive log current;




change failure 2122 closed; /* 만기된 문법이나, 현재까진 정상 동작 */




ALTER TABLESPACE data_tbs ADD DATAFILE '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf' size 10m;
--list backup of datafile 4;
list backup of datafile '/u01/app/oracle/oradata/ORA19C/data_tbs02.dbf';




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
