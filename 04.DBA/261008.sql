select * from v$parameter where name = 'spfile'; /* 초기 파라미터 파일 조회 */
select * from v$parameter where isdefault = 'TRUE'; /* Bool 타입은 PL SQL 전용 타입이므로, 문자열 'TRUE' */

select * from v$parameter where ISSYS_MODIFIABLE = 'FALSE'; /* Static Parameter 조회 */
select * from v$parameter where ISSYS_MODIFIABLE IN ('IMMEDIATE', 'DEFERRED'); /* Dynamic Parameter 조회 */

select * from v$parameter where ISSYS_MODIFIABLE = 'DEFERRED';
select * from v$parameter where name = 'open_cursors'; /* open_cursors == SQL 문을 실행하는 메모리 영역 */
alter system reset sort_area_size = 65536 DEFERRED SCOPE=BOTH;
alter system reset sort_area_size = 1048576 DEFERRED SCOPE=BOTH; /*  DEFERRED 파라미터는, ' DEFERRED  ' 키워드 필수 */
show parameter sort_area_size;

alter system reset open_cursors SCOPE=BOTH; /* 파라미터 값을, 디폴트로 초기화 */
