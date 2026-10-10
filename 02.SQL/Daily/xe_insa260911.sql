SHOW USER;
SELECT * FROM USER_SYS_PRIVS;  /* 현재 접속한 사용자의(본인) 시스템 권한 조회 */
SELECT * FROM ROLE_SYS_PRIVS; /* 현재 접속한 사용자가(본인) 부여받은 ROLE 內 시스템 권한 목록 조회 */
SELECT * FROM USER_TAB_PRIVS; /* 현재 접속한 사용자가(본인) 소유한 객체에, 부여된 ' 객체 권한 ' 조회 */
SELECT * FROM SESSION_ROLES; /* 현재 접속한 사용자가(본인) 부여받은 ROLE 조회 */
SELECT * FROM SESSION_PRIVS; /* 현재 접속한 사용자가(본인) ROLE 통해서 받거나, 직접 부여받은 ' 시스템 권한 ' 조회 ( USER_SYS_PRIVS UNION ROLE_SYS_PRIVS )*/
SELECT * FROM USER_TS_QUOTAS; /* 현재 접속한 사용자의(본인) TABLESPACE QUOTA 조회 */


SELECT * FROM USER_OBJECTS; /* 현재 접속한 사용자가(본인) 소유한 객체 조회 */
SELECT * FROM USER_TABLES; /* 현재 접속한 사용자가(본인) 소유한 테이블 정보 */
SELECT * FROM USER_TAB_COLUMNS; /* 현재 접속한 사용자가(본인) 소유한 테이블의 컬럼 */
SELECT * FROM USER_USERS; /* 현재 접속한 사용자(본인)의 정보 */
