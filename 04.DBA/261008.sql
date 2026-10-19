SELECT * FROM v$parameter WHERE NAME = 'spfile'; /* 초기 파라미터 파일 조회 */
SELECT * FROM v$parameter WHERE isdefault = 'TRUE'; /* Bool 타입은 PL SQL 전용 타입이므로, 문자열 ' TRUE ' */


SELECT * FROM v$parameter WHERE issys_modifiable = 'FALSE'; /* Static Parameter 조회 */
SELECT * FROM v$parameter WHERE issys_modifiable IN ('IMMEDIATE', 'DEFERRED'); /* Dynamic Parameter 조회 */
SELECT * FROM v$parameter WHERE issys_modifiable = 'DEFERRED'; /* Dynamic Parameter 中 ' ISSYS_MODIFIABLE = DEFERRED ' Parameter 조회 */


SELECT * FROM v$parameter WHERE NAME = 'open_cursors'; /* open_cursors == SQL 문을 실행하는 메모리 영역 */
ALTER SYSTEM SET sort_area_size = 65536 DEFERRED SCOPE=BOTH;
ALTER SYSTEM SET sort_area_size = 1048576 DEFERRED SCOPE=BOTH; /*  DEFERRED 파라미터는, ' DEFERRED  ' 키워드 필수 */
SHOW PARAMETER sort_area_size; /* DEFERRED 파라미터는, ' SCOPE=BOTH ' 수정시, DB 접속 해제 後 재접속 또는, 새로운 세션에서 VALUE ' 1048576 ' 수정되어 있다 */


ALTER SYSTEM RESET open_cursors SCOPE=BOTH; /* 파라미터 값을, 디폴트로 초기화 */

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
