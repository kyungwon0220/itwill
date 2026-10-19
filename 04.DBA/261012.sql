select rowid, e.* from hr.employees e; /* ROWID */
select * from dba_objects where object_name = 'EMPLOYEES'; /* DATA_OBJECT_ID == 객체 고유 번호 */
select * from dba_tables where table_name = 'EMPLOYEES'; /* ' TABLESPACE_NAME ' == 테이블 스페이스명 */
select * from dba_data_files where tablespace_name = 'SYSAUX'; /* FILE_ID */
select * from dba_extents where segment_name = 'EMPLOYEES'; /* BLOCK_ID */

select * from dba_segments where segment_name = 'EMP_EMP_ID_PK'; /* 인덱스 Segment HEADER_BLOCK 다음 BLOCK == ROOT BLOCK */
select * from dba_extents where segment_name = 'EMP_EMP_ID_PK';

SELECT * FROM v$sga_dynamic_components; /* ' sga_target ' 설정시 보는, Dictionary View */

SHOW SGA;
SHOW PARAMETER sga_max_size; /* ' SHOW SGA; ' 內 ' Total System Gllobal Area ' 값 */
SELECT * FROM v$parameter WHERE NAME = 'sga_max_size'; /* ' ISSYS_MODIFIABLE = 'FALSE' ' == Static Parameter */

SELECT * FROM dba_segments WHERE tablespace_name = 'SYSTEM'; /* Data Dicionary == Segment */
SELECT * FROM v$sgastat;
SHOW PARAMETER sga_target;
SHOW PARAMETER shared_pool_size; /* VALUE == 0 == 크기를, 오라클이 자동 관리한다는 의미 */
SELECT * FROM v$sgainfo;

SELECT * FROM v$sgainfo WHERE NAME = 'Large Pool Size';
SELECT * FROM v$parameter WHERE NAME = 'large_pool_size';

SHOW PARAMETER db_block_size; /* 초기 파라미터 파일 上 ' db_block_size ' Parameter */
SELECT * FROM user$;
SELECT * FROM v$parameter WHERE NAME IN ('db_cache_size',
                                            'db_keep_cache_size',
                                            'db_recycle_cache_size',
                                            'db_2k_cache_size',
                                            'db_4k_cache_size',
                                            'db_8k_cache_size',
                                            'db_16k_cache_size',
                                            'db_32k_cache_size');

SELECT * FROM v$parameter WHERE NAME = 'log_buffer';

SELECT * FROM v$parameter WHERE NAME IN ('sga_max_size', 'sga_target');
SELECT * FROM v$sga_dynamic_components; /* ' sga_target ' 설정시 보는, Dictionary View */

SELECT * FROM v$parameter WHERE NAME IN ('pga_aggregate_target', 'workarea_size_policy');
