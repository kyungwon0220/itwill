select sql_id, sql_text, parse_calls, loads, executions, plan_hash_value, hash_value from v$sql
where sql_text like '%hr.employees%' and sql_text not like '%v$sql%';

select * from table(dbms_xplan.display_cursor('09f16j5673k2r')); /* SQL_ID ' 09f16j5673k2r ', Ω««‡ ∞Ë»π */

alter system flush shared_pool; /* FLUSH */
