select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_db_percent_hot_default';
--_db_percent_hot_default	50 /* Hot 영역, Cold 영역 % */

select a.ksppinm parameter, b.kspps             tvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_db_block_max_scan_pct'; /* LRU List 內 Free Buffer 40% Scan (40% 스캔해도 Free Buffer 못찾을시, DBWR 프로세스는 Dirty Buffer Write 작업 後 Free Buffer 확보 요청 */
--_db_block_max_scan_pct	40

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_db_aging_touch_time';
--_db_aging_touch_time	3 /* 처음 Acess 後 3초 이후 Access 時 1씩 증가 ( Defalut 3 ) */

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_db_aging_hot_criteria';
--_db_aging_hot_criteria	2 /* ' 2 ' == Touch Count 2 이상일시, Hot 영역으로 옮긴다는 의미 */

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_db_aging_cool_count';
--_db_aging_cool_count	1 /* Cold 영역으로 이동시, Touch Count 초기화 값 */

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx and a.ksppinm = '_db_aging_stay_count';
--_db_aging_stay_count	0




select a.bp_blksz, c.child#, a.bp_name, c.gets, c.misses, c.sleeps
from x$kcbwbpd a, x$kcbwds b, v$latch_children c
where b.set_id between a.bp_lo_sid and a.bp_hi_sid and c.addr = b.set_latch
order by 1, 2;

select a.bp_blksz, c.child#, a.bp_name, c.gets, c.misses, c.sleeps
from x$kcbwbpd a, x$kcbwds b, v$latch_children c
where b.set_id between a.bp_lo_sid and a.bp_hi_sid and c.addr = b.set_latch
order by 1,2;
--2048	13	DEFAULT	14	    0	0
--2048	15	DEFAULT	14	    0	0
--4096	17	DEFAULT	14	    0	0
--4096	19	DEFAULT	14	    0	0
--8192	1	KEEP	14	    0	0
--8192	3	KEEP	14	    0	0
--8192	5	RECYCLE	14	    0	0
--8192	7	RECYCLE	14	    0	0
--8192	9	DEFAULT	9897	2	0 /* 현재 사용중인 Cache Buffers LRU Chain Latch */
--8192	11	DEFAULT	9276	0	0 /* 현재 사용중인 Cache Buffers LRU Chain Latch */
--8192	21	DEFAULT	14	    0	0
--8192	23	DEFAULT	14	    0	0
--8192	33	DEFAULT	14	    0	0
--8192	35	DEFAULT	14	    0	0
--16384	25	DEFAULT	14	    0	0
--16384	27	DEFAULT	14	    0	0
--32768	29	DEFAULT	14	    0	0
--32768	31	DEFAULT	14	    0	0




select * from dba_indexes where owner = 'HR'; /* ' BLEVEL ' == 0 == Root Block == Leaf Block (' BLEVEL ' == 3 == Root Block, Branch Block, Leaf Block 의미)  */




alter system flush shared_pool;
alter system flush buffer_cache;
