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
AS /* CTAS */
SELECT *
    FROM HR.EMPLOYEES;


CREATE TABLE CTAS_EMP2
TABLESPACE users
AS /* CTAS */
SELECT employee_id, last_name || ' ' || first_name AS "name" /* CTAS 內 SELECT 표현식에서는 별칭 필수 ( 별칭 지정 안할시 ERR 발생 ) */
    FROM HR.EMPLOYEES;


CREATE TABLE CTAS_EMP3
TABLESPACE users
AS
SELECT *
    FROM HR.EMPLOYEES
    WHERE 1 = 2; /* 조건절을 FALSE 만들시, DATA 내용 없이 테이블의 구조 뼈대만 복제 */


INSERT INTO CTAS_EMP3 SELECT *
                        FROM HR.EMPLOYEES; /* INSERT SUBQUERY */


SELECT * FROM CTAS_EMP3;
DROP TABLE CTAS_EMP3 PURGE;


CREATE TABLE HR.MGR
TABLESPACE users
AS /* CTAS */
SELECT employee_id, UPPER(last_name) name, TO_CHAR(hire_date, 'yyyy-mm-dd') day, TO_CHAR(salary, 'L999,999.00') sal /* CTAS 內 SELECT 표현식에서는 별칭 필수 ( 별칭 지정 안할시 ERR 발생 ) */
FROM HR.EMPLOYEES o
WHERE EXISTS (SELECT NULL
                FROM HR.EMPLOYEES
                WHERE manager_id = o.employee_id);


INSERT INTO HR.MGR(employee_id, name, day, sal)
SELECT employee_id, UPPER(last_name), TO_CHAR(hire_date, 'yyyy-mm-dd'), TO_CHAR(salary, 'L999,999.00')
FROM HR.EMPLOYEES o
WHERE EXISTS ( SELECT NULL /* Correlate Subquery ( 상호 관련 서브 쿼리 ) 이용한, INSERT ( 별칭 없어도 정상 동작 ) */
                FROM HR.EMPLOYEES
                WHERE MANAGER_ID = o.EMPLOYEE_ID);


DESC HR.MGR;
SELECT * FROM HR.MGR;
TRUNCATE TABLE HR.MGR;
DROP TABLE HR.MGR PURGE;


CREATE TABLE HR.EMP4(id NUMBER, name VARCHAR2(60), dept_id NUMBER, dept_name VARCHAR2(30))
TABLESPACE users;


INSERT INTO HR.EMP4(id, name) SELECT employee_id, last_name || ' ' || first_name
                                FROM HR.EMPLOYEES;


UPDATE HR.EMP4 o
SET dept_id = (SELECT department_id
                FROM HR.EMPLOYEES
                WHERE employee_id = o.id); /* Correlate Subquery ( 상호 관련 서브 쿼리 ) 이용한, UPDATE */


UPDATE HR.EMP4 o
SET dept_name = (SELECT department_name
                    FROM HR.DEPARTMENTS
                    WHERE department_id = o.dept_id); /* Correlate Subquery ( 상호 관련 서브 쿼리 ) 이용한, UPDATE */


DELETE FROM HR.EMP4
WHERE id IN (SELECT employee_id /* DELETE Subquery */
                FROM HR.EMPLOYEES
                WHERE hire_date >= TO_DATE('2006-01-01', 'yyyy-mm-dd') AND hire_date < TO_DATE('2007-01-01', 'yyyy-mm-dd'));


DELETE FROM HR.EMP4 o 
WHERE EXISTS (SELECT NULL
                FROM HR.EMPLOYEES
                WHERE hire_date >= TO_DATE('2006-01-01', 'yyyy-mm-dd') AND hire_date < TO_DATE('2007-01-01', 'yyyy-mm-dd')
                AND EMPLOYEE_ID = o.ID); /* Correlate Subquery ( 상호 관련 서브 쿼리 ) 이용한, DELETE */


DESC HR.EMP4;
SELECT * FROM HR.EMP4;
DROP TABLE HR.EMP4 PURGE;


CREATE TABLE HR.SAL_HISTORY(id NUMBER, day DATE, sal NUMBER)
TABLESPACE users;


CREATE TABLE HR.MGR_HISTORY(id NUMBER, mgr NUMBER, sal NUMBER)
TABLESPACE users;


INSERT INTO HR.SAL_HISTORY(id, day, sal)
SELECT employee_id, hire_date, salary
FROM HR.EMPLOYEES;


INSERT INTO HR.MGR_HISTORY(id, mgr, sal)
SELECT employee_id, manager_id, salary
FROM HR.EMPLOYEES;


SELECT * FROM HR.SAL_HISTORY;
SELECT * FROM HR.MGR_HISTORY;
DROP TABLE HR.MGR_HISTORY PURGE;


--- 다중 테이블 INSERT(9i)
--- 소스 테이블에서 데이터를 추출하여, 여러 타겟 테이블에 데이터를 INSERT
--- ETL(Extraction(추출), Transformation(변형), Loading(적재))
INSERT ALL /* Multi Table INSERT */
	INTO HR.SAL_HISTORY(id, day, sal) VALUES(no, hire, sal) /* 타겟 */
	INTO HR.MGR_HISTORY(id, mgr, sal) VALUES(no, mgr, sal) /* 타겟 */
SELECT employee_id no, manager_id mgr, hire_date hire, salary * 12 sal
FROM HR.EMPLOYEES;


INSERT ALL
WHEN day < TO_DATE('2005-01-01', 'yyyy-mm-dd') AND sal >= 5000 THEN /* 조건 Multi Table INSERT */
    INTO HR.SAL_HISTORY(id, day, sal) VALUES(id, day, sal)
WHEN comm IS NOT NULL THEN
    INTO HR.MGR_HISTORY(id, comm, sal) VALUES(id, comm, sal)
SELECT employee_id ID, hire_date DAY, salary SAL, commission_pct comm
FROM HR.EMPLOYEES;


CREATE TABLE HR.SAL_LOW(id NUMBER, name VARCHAR2(30), sal (NUMBER)
TABLESPACE users;


CREATE TABLE HR.SAL_MID(id NUMBER, name VARCHAR2(30), sal NUMBER)
TABLESPACE users;


CREATE TABLE HR.SAL_HIGH(id NUMBER, name VARCHAR2(30), sal NUMBER)
TABLESPACE users;

SELECT * FROM TAB;
INSERT FIRST /* */
WHEN salary < 5000 THEN
    INTO HR.SAL_LOW(id, name, sal)
    VALUES(employee_id, last_name, salary)
WHEN salary BETWEEN 5000 AND 10000 THEN
    INTO HR.SAL_MID(id, name, sal)
    VALUES(employee_id, last_name, salary)
ELSE
    INTO HR.SAL_HIGH(id, name, sal)
    VALUES(employee_id, last_name, salary)
SELECT employee_id, salary, last_name
FROM HR.EMPLOYEES;


SELECT * FROM HR.SAL_HIGH;
DROP TABLE HR.SAL_HIGH PURGE;
