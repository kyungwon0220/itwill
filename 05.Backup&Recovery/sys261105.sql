alter system archive log current;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	1	YES	INACTIVE	2509329	2026-11-05 18:13:23	2509357	                2026-11-05 18:14:26
--1	4	/u01/app/oracle/oradata/ORA19C/redo01.log	200	1	NO	CURRENT	    2539459	2026-11-05 23:33:08	18446744073709551615	
--3	3	/u01/app/oracle/oradata/ORA19C/redo03.log	200	1	YES	ACTIVE	    2509357	2026-11-05 18:14:26	2539459	                2026-11-05 23:33:08




--*.compatible='19.0.0'
--*.control_files='/home/oracle/backup/clone/control01.ctl'
--*.db_name='clone'
--*.log_archive_dest_2='location=/home/oracle/backup/clone/ mandatory'
--*.log_archive_format='arch_%t_%s_%r.arc'
--*.undo_tablespace='UNDO1'




--orapwd file=orapwclone password=oracle format=12 /* OS 內 ' $ORACLE_HOME/dbs ' 경로에 oracle ' PW, 인증 추가 */




select dbms_metadata.get_ddl('USER','HR') from dual;
select default_tablespace, temporary_tablespace from dba_users where username= 'HR';

select 'GRANT ' || PRIVILEGE || ' TO ' || GRANTEE || ';' from dba_sys_privs where grantee = 'HR';
--GRANT CREATE DATABASE LINK TO HR;
--GRANT ALTER SESSION TO HR;
--GRANT CREATE VIEW TO HR;
--GRANT UNLIMITED TABLESPACE TO HR;
--GRANT CREATE SESSION TO HR;
--GRANT CREATE SEQUENCE TO HR;
--GRANT CREATE SYNONYM TO HR;
select dbms_metadata.get_granted_ddl('SYSTEM_GRANT', 'HR') from dual;
--"
--  GRANT CREATE SESSION TO "HR"
--  GRANT ALTER SESSION TO "HR"
--  GRANT UNLIMITED TABLESPACE TO "HR"
--  GRANT CREATE SYNONYM TO "HR"
--  GRANT CREATE VIEW TO "HR"
--  GRANT CREATE SEQUENCE TO "HR"
--  GRANT CREATE DATABASE LINK TO "HR"
--"




create directory pump_dir as '/home/oracle/data_pump'; /* Data Pump Dir, 변수처럼 지정 */
select * from dba_directories where directory_name = 'PUMP_DIR';
grant read, write on directory pump_dir to hr;
select * from dba_tab_privs where grantee = 'HR';
--HR	SYS	DBMS_STATS	SYS	EXECUTE	NO	NO	NO	PACKAGE	NO

create table hr.emp tablespace users as select * from hr.employees; /* CTAS == 제약 조건은, ' NOT NULL ' 제약 조건만 복제ㄷ */
alter table hr.emp add constraint emp_id_pk primary key(employee_id);
select * from hr.emp;

select constraint_name, constraint_type, search_condition, status, index_name from dba_constraints where owner = 'HR' and table_name = 'EMP';
--SYS_C007587	C	"LAST_NAME" IS NOT NULL	ENABLED	
--SYS_C007588	C	"EMAIL"     IS NOT NULL	ENABLED	
--SYS_C007589	C	"HIRE_DATE" IS NOT NULL	ENABLED	
--SYS_C007590	C	"JOB_ID" IS NOT NULL	ENABLED	
    SYS_C007587	C	"LAST_NAME" IS NOT NULL	ENABLED	
    SYS_C007588	C	"EMAIL"     IS NOT NULL	ENABLED	
    SYS_C007589	C	"HIRE_DATE" IS NOT NULL	ENABLED	
    SYS_C007590	C	"JOB_ID"    IS NOT NULL	ENABLED	
    EMP_ID_PK	P		                    ENABLED	EMP_ID_PK

--expdp system/oracle schemas=hr dumpfile=hr_schema.dmp directory=pump_dir /* OS 內 User Level Dump File 생성 ( Export ) */

drop table hr.emp purge; /* 테이블의 Data, 제약 조건, Index 모두 삭제 */

--impdp system/oracle directory=pump_dir dumpfile=hr_schema.dmp tables=hr.emp /* User Level Table Import */

create user james identified by oracle default tablespace sysaux temporary tablespace temp quota unlimited on sysaux;

--impdp system/oracle dumpfile=hr_table.dmp directory=pump_dir tables=hr.emp remap_schema='hr':'james' remap_tablespace='users':'sysaux' /* 다른 유저에게, Table Import */

select owner, table_name, tablespace_name from dba_tables where table_name = 'EMP';
--HR	EMP	USERS
    HR	EMP	USERS
    JAMES	EMP	SYSAUX

drop table hr.job_history purge;
truncate table hr.job_history;
select * from hr.job_history;
desc hr.job_history;

--expdp system/oracle dumpfile=hr_james_emp_dept_job.dmp directory=pump_dir tables=hr.employees,hr.departments,hr.job_history,james.emp /* 특정 유저의 테이블 Export */
--impdp system/oracle dumpfile=hr_james_emp_dept_job.dmp directory=pump_dir tables=hr.job_history /* Table Level Table Import */
--impdp system/oracle dumpfile=hr_james_emp_dept_job.dmp directory=pump_dir tables=hr.job_history content=metadata_only /* Meta 데이터만 Import */
--impdp system/oracle dumpfile=hr_james_emp_dept_job.dmp directory=pump_dir tables=hr.job_history content=data_only /* Meta Data 아닌, 실제 데이터만 Import ( Meta 정보 불일치시 Import 불가 ERR ) */




select * from hr.employees where department_id = 50 and job_id = 'ST_MAN';
create table hr.emp_50_stman tablespace users as select * from hr.employees where 1=2;
select * from hr.emp_50_stman;

--expdp system/oracle dumpfile=hr_50_stman.dmp directory=pump_dir tables=hr.employees query=hr.employees:\"where department_id\=50 and job_id\=\'ST_MAN\'\" /* 특정 조건절에 해당하는 결과만, Export ( ' select * from hr.employees where department_id = 50 and job_id = 'ST_MAN'; ' 실행 결과 ) */
--impdp system/oracle dumpfile=hr_50_stman.dmp directory=pump_dir remap_table=employees:emp_50_stman content=data_only /* 원하는 테이블명으로 Import 가능 (Table Meta data 불일치시 Import ERR) */
