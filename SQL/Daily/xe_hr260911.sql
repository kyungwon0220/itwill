SHOW USER;
SELECT * FROM USER_SYS_PRIVS;  /* 현재 접속한 사용자의(본인) 시스템 권한 조회 */
SELECT * FROM ROLE_SYS_PRIVS; /* 현재 접속한 사용자가(본인) 부여받은 ROLE 內 시스템 권한 조회 */
SELECT * FROM USER_TAB_PRIVS; /* 현재 접속한 사용자가(본인) 소유한 객체에, 부여된 ' 객체 권한 ' 조회 */
SELECT * FROM SESSION_ROLES; /* 현재 접속한 사용자가(본인) 부여받은 ROLE 조회 */
SELECT * FROM SESSION_PRIVS; /* 현재 접속한 사용자가(본인) ROLE 통해서 받거나, 직접 부여받은 ' 시스템 권한 ' 조회 ( USER_SYS_PRIVS UNION ROLE_SYS_PRIVS )*/
SELECT * FROM USER_TS_QUOTAS; /* 현재 접속한 사용자의(본인) TABLESPACE QUOTA 조회 */


SELECT * FROM USER_OBJECTS; /* 현재 접속한 사용자가(본인) 소유한 객체 조회 */
SELECT * FROM USER_TABLES; /* 현재 접속한 사용자가(본인) 소유한 테이블 정보 */
SELECT * FROM USER_TAB_COLUMNS; /* 현재 접속한 사용자가(본인) 소유한 테이블의 컬럼 */
SELECT * FROM USER_USERS; /* 현재 접속한 사용자(본인)의 정보 */

CREATE TABLE CTAS_EMP
TABLESPACE users
AS
SELECT * FROM HR.EMPLOYEES;


CREATE TABLE CTAS_EMP2
TABLESPACE users
AS
SELECT employee_id, last_name || ' ' || first_name AS "name" FROM HR.EMPLOYEES; /* 표현식에서는 별칭 필수 ( 별칭 지정 안할시 ERR 발생 ) */


CREATE TABLE CTAS_EMP3
TABLESPACE users
AS
SELECT * FROM HR.EMPLOYEES WHERE 1 = 2; /* 조건절을 FALSE 만들시, 내용없이 뼈대만 복제 */


INSERT INTO CTAS_EMP3 SELECT * FROM HR.EMPLOYEES; /* INSERT SUBQUERY */


SELECT * FROM CTAS_EMP3;
DROP TABLE CTAS_EMP3 PURGE;


CREATE TABLE HR.MGR(id NUMBER(3), name VARCHAR2(30), day DATE)
TABLESPACE users;


INSERT INTO HR.MGR(id, name, day)
SELECT employee_id, UPPER(last_name) name, TO_CHAR(hire_date, 'yyyy-mm-dd') day /* 표현식 존재시, 별칭 지정 필수 */
FROM HR.EMPLOYEES o
WHERE EXISTS ( SELECT NULL /* Correlate Subquery 이용한, INSERT */
                FROM HR.EMPLOYEES
                WHERE MANAGER_ID = o.EMPLOYEE_ID);


INSERT INTO HR.MGR(employee_id, name, day, sal)
SELECT employee_id, UPPER(last_name, TO_CHAR(hire_date, 'yyyy-mm-dd'), TO_CHAR(salary, 'L999,999.00')
FROM HR.EMPLOYEES o
WHERE EXISTS ( SELECT NULL
                FROM HR.EMPLOYEES
                WHERE manager_id = o.employee_id);


DROP TABLE HR.MGR PURGE;
SELECT * FROM MGR;
