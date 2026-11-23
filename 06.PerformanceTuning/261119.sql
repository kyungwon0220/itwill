begin
    for i in 1..10000 loop
        execute immediate 'create or replace procedure p1 is begin null; end;';
    end loop;
end;
/ /* 다른 2개의 세션에서 각각 수행시, p1 생성중에 다른 세션은 Library Cache Wait Event 발생 */

select sid, event, wait_class, wait_time, seconds_in_wait, state /* ' SID ' == Session ID, ' EVENT ' == 대기 Event 정보, ' WAIT_TIME ' == 대기 시간(1/100초 단위), ' SECONDS_IN_WAIT ' == 대기 시간(초 단위) */
from v$session_wait /* 세션의 대기 Event 실시간 조회 ( 지나간 Event 조회 불가 ) */
where sid in (select sid from v$session where username = 'HR');

select sid, event, total_waits, time_waited /* ' TOTAL_WAITS ' == 전체 대기 횟수, ' TIME_WAITED ' == 전체 대기 시간(1/100초 단위) */
from v$session_event /* 세션의 누적 Wait 정보 */
where sid in (select sid from v$session where username='HR');




select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_kghdsidx_count'; /* Hidden Parameter 조회 */
--_kghdsidx_count	1

select name, gets from v$latch_children where name = 'shared pool';
--shared pool	8
--shared pool	8
--shared pool	8
--shared pool	8
--shared pool	8
--shared pool	8
--shared pool	679398




select sid, username, prev_sql_id, sql_id from v$session where sid in (414,16);

SELECT SQL_ID, SQL_TEXT, PARSE_CALLS, LOADS, EXECUTIONS, PLAN_HASH_VALUE, HASH_VALUE, INVALIDATIONS
FROM v$sql
where sql_id = '9babjv8yq8ru3';




show parameter session_cached_cursors; /* 하나의 Session 內 3회 이상 수행된 SQL 커서들의 Library Cache 위치와, SQL 문장을 PGA 영역에 저장하는 개수 */
--session_cached_cursors integer 50




SELECT SQL_ID, SQL_TEXT, PARSE_CALLS, LOADS, EXECUTIONS, PLAN_HASH_VALUE, HASH_VALUE, INVALIDATIONS
FROM v$sql
where sql_text like '%hr.employees%' and sql_text not like '%v%sql%';
--8d2z7yw6uhukn	 select employee_id, salary from hr.employees where last_name=:name	1	1	1	1283055559	229141076	0
    8d2z7yw6uhukn	 select employee_id, salary from hr.employees where last_name=:name	2	1	2	1283055559	229141076	0
--8d2z7yw6uhukn	 select employee_id, salary from hr.employees where last_name=:name	2	1	2	1283055559	229141076	0
--83wz5jugta7r1	select employee_id, salary from hr.employees where last_name=:name	2	1	2	1283055559	2677350113	0

select sql_id, sql_text, version_count, address, hash_value /* version_count == ChildCursor 조회 */
from v$sqlarea
where sql_text like '%hr.employees%' and sql_text not like '%v%sql%';
--8d2z7yw6uhukn	 select employee_id, salary from hr.employees where last_name=:name	1
    8d2z7yw6uhukn	    select employee_id, salary from hr.employees where last_name=:name	1	0000000065C09EE0	229141076
    83wz5jugta7r1	    select employee_id, salary from hr.employees where last_name=:name	1	00000000657AFEE8	2677350113

select * /* address, child_address, child_number, bind_length_upgradeable */
from v$sql_shared_cursor /* Child Cursor 생성 이유 조회 */
where sql_id = '83wz5jugta7r1';
--0000000065C09EE0	0000000065C0BF98	0	N
    00000000657AFEE8	000000006580E508	0	N

select * from table(dbms_xplan.display_cursor('83wz5jugta7r1', 0));
--SQL_ID  8d2z7yw6uhukn, child number 0
---------------------------------------
-- select employee_id, salary from hr.employees where last_name=:name
-- 
--Plan hash value: 1283055559
-- 
------------------------------------------------------------------------------------------------------------------------
--| Id  | Operation                           | Name                           | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT                    |                                |       |       |     2 (100)|          |
--|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEES                      |     2 |    32 |     2   (0)| 00:00:01 |
--|*  2 |   INDEX RANGE SCAN                  | BIN$YHO1YMtqSvngZdIssULvsQ==$0 |     2 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   2 - access("LAST_NAME"=:NAME)
    SQL_ID  83wz5jugta7r1, child number 0
    -------------------------------------
    select employee_id, salary from hr.employees where last_name=:name
     
    Plan hash value: 1283055559
     
    -----------------------------------------------------------------------------------------------------------
    | Id  | Operation                           | Name                           | Rows  | Bytes | Cost (%CPU)|
    -----------------------------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT                    |                                |       |       |     1 (100)|
    |   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEES                      |     1 |    16 |     0   (0)|
    |*  2 |   INDEX RANGE SCAN                  | BIN$YHO1YMtqSvngZdIssULvsQ==$0 |     1 |       |     0   (0)|
    -----------------------------------------------------------------------------------------------------------
     
    Predicate Information (identified by operation id):
    ---------------------------------------------------
     
       2 - access("LAST_NAME"=:NAME)

select address, child_address, child_number, datatype_string, max_length, value_string
from v$sql_bind_capture 
where sql_id ='83wz5jugta7r1'; /* Bind 변수의 Varchar2 타입의 크기는, 내부적으로 실제 32byte, 128byte, 2000byte, 4000byte 4가지 크기로 결정된다 */
--0000000065C09EE0	0000000065C0BF98	0	VARCHAR2(32)	32	King
    00000000657AFEE8	000000006580E508	0	VARCHAR2(16386)	16386	NULL




--exec dbms_shared_pool.purge('00000000657AFEE8.2677350113', 'c'); /* 특정 Cursor Purge ( ' {ADDRESS}.{HASH_VALUE} ' ) */
