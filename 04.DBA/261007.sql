select * from v$instance; /* INSTANCE_NAME == SID(System IDentifier) */
select * from v$database; /* DB 정보 */
select * from v$process;
select * from v$sga;
select * from v$parameter;
select * from v$datafile;
select * from v$tempfile;
select * from v$log;
select * from v$logfile;
select * from v$session;




select * from v$parameter where name = 'sga_max_size';
select * from v$sgastat;
select * from dba_segments where tablespace_name = 'SYSTEM'; /* Data Dicionary 테이블들 == 세그먼트 */
show parameter shared_pool_size;
select * from v$parameter where name = 'shared_pool_size'; /* VALUE == 0 의미는, 오라클이 내부적으로 자동 관리 */
show parameter sga_target;
show parameter large_pool_size; /* VALUE == 0 의미는, 오라클이 내부적으로 자동 관리 */
select * from v$sgainfo;
select * from v$parameter where name = 'java_pool_size';
select * from v$parameter where name = 'streams_pool_size';
show parameter db_block_size;
select * from v$parameter where name in ('db_cache_size', 'db_keep_cache_size', 'db_recycle_cache_size', 'db_2k_cache_size', 'db_4k_cache_size', 'db_8k_cache_size', 'db_16k_cache_size', 'db_32k_cache_size');
