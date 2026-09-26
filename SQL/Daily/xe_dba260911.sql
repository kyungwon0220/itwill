SELECT * FROM DBA_TABLES; /* 테이블 정보용 공식 Dictionary View ( DB 전체의 테이블을 확인할 수 있는 권한 필요 ) */
SELECT * FROM DBA_USERS; /* DB 전체 사용자 정보 ( DBA 권한 또는 해당 데이터 딕셔너리 뷰를 조회할 수 있는 권한 필요 )*/
SELECT * FROM SYS.TAB$; /* Oracle 내부 데이터 딕셔너리 테이블 ( 내부 구현에 사용하는 테이블로서, 일반적인 SQL 개발에서는 직접 조회하기보다 공식 Data Dictionary View 사용 권장 ) */
SELECT * FROM DBA_TEMP_FILES; /* 임시 테이블 스페이스 조회 */


SELECT * FROM DBA_ROLES; /* 현재 DB에 생성되어있는 ROLE 확인 */
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT'; /* ' CONNECT ' 이름을 가진 ROLE 內 들어있는 권한들 조회 */
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'ORA1'; /* ' ORA1 ' 유저에게 ROLE 통하지 않고, 직접 부여한 시스템 권한 조회 */
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'ORA1'; /* ' ORA1 ' 유저에게 부여한 ROLE 조회 */
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'INSA'; /* ' INSA ' 유저에게 부여한 객체 권한 조회 */
SELECT * FROM DBA_TS_QUOTAS; /* DB 전체 사용자의, TABLESPACE QUOTA 조회 ( QUOTA 부여한 유저 정보 조회 ) */


ALTER USER ORA1
QUOTA 1M
ON USERS;
