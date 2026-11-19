select * from v$sgastat where pool='shared pool';

select cache#, parameter from v$rowcache; /* Dicionary Cache 內 Dicionary 정보들 ( 상세 내용은 Oracle 미공개 ) */

select table_name from dba_tables where tablespace_name = 'SYSTEM'; /* System Tablespace 內 Dicionary 테이블들 (이런 정보들로, Oracle 관리) */




select * from sys.user$ where name = 'HR';
select * from sys.obj$ where owner# = 108 and name = 'EMPLOYEES'; /* ' sys.user$ ' 內 ' user# ' */
select * from sys.tab$ where obj#=73975;
select * from sys.col$ where obj#=73975;
select * from sys.objauth$ where obj#=73975;
select * from sys.sysauth$ where grantee#=108;

select * from dba_users where username = 'HR'; /* 실행 계획을 살펴보면, 내부적으로 TS# 등의 테이블들을 Join, 보기 편한 View 제공 */
select * from dba_objects where owner = 'HR' and object_name = 'EMPLOYEES';




select last_name, first_name, salary, department_id from hr.employees where employee_id = 102;
select * from hr.employees where employee_id = 102;

alter system flush shared_pool;

select sql_id, sql_text, parse_calls, loads, executions, hash_value, plan_hash_value, invalidations
from v$sql
where sql_text like '%hr.employees%' and sql_text not like '%v$sql%';
--czmhpuznkxr1r	select *                                            from hr.employees where employee_id = 102	1	1	1	3912162359	1273725204	0
--aty85b0d3ght8	select last_name, first_name, salary, department_id from hr.employees where employee_id = 102	1	1	1	439862056	1273725204	0

select * from v$sql_plan where sql_id = '82mnzcywm53rs';

select * from table(dbms_xplan.display_cursor('82mnzcywm53rs')); /* 실행 계획 조회 */




select count(*) from hr.employees;
create table hr.emp tablespace users as select * from hr.employees; /* CATS Table 복제 時 Auto 통계 수집ㄷ */
--DROP TABLE hr.employees CASCADE CONSTRAINTS;
--FLASHBACK TABLE hr.employees TO BEFORE DROP;
drop table hr.emp purge;

create table hr.emp tablespace users as select * from hr.employees where 1=2; /* Data 로드없는 CTAS 時 통계 수집되지 않 */
insert into hr.emp select * from hr.employees;
select count(*) from hr.emp;

alter table hr.employees drop primary key;
alter table hr.employees add constraint emp_id_pk primary key(employee_id); /* PK 제약 조건을 걸면, Index 생성으로 인해, 관련된 모든 LCO 찾아서, 실행 계획 무효화로 ' invalidations ' 증가 ( 모든 LCO 찾는 과정에서 Mutex 잡아야 하기에, 현장에서는 주의 ) */
create unique index hr.emp_idx on hr.emp(employee_id); /* Index 추가시에도, 이와 관련된 모든 LCO 찾아서, 실행 계획 무효화로 ' invalidations ' 증가 ( 기존의 실행 계획 사용 불가 ) */
alter table hr.employees modify last_name varchar2(40); /* Table 구조 변경시에도, 실행 계획 무효화로 ' invalidations ' 증가 ( 기존의 실행 계획 사용 불가로, 실행 계획 Hard Parsing ) */

--exec dbms_stats.gather_table_stats('hr', 'emp'); /* 수동 Table 통계 수집 */
select num_rows, blocks, avg_row_len, to_char(last_analyzed, 'yyyy-mm-dd hh24:mi:ss') from dba_tables where owner = 'HR' and table_name = 'EMP'; /* Table 통계 조회 */
--0	0	0	2026-11-18 08:51:13 /* ' AVG_ROW_LEN ' == ROW 평균 byte 값 */
    106	5	69	2026-11-18 08:52:47
