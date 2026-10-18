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
