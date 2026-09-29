SELECT *
FROM SYS.OBJ$ /* 실제 DATA 저장된 테이블로서, 일반 유저는 조회 불가 ( 테이블, 인덱스, 뷰, 프로시저 등 모든 객체의 기본 메타 정보가 마스터격 )*/
WHERE name = 'EMPLOYEES';


SELECT *
FROM DBA_OBJECTS
WHERE OBJECT_NAME = 'EMPLOYEES'; /* ' SYS.OBJ$ ' 테이블에 대해 GUI 고려한 VIEW */


SELECT *
FROM DBA_CONSTRAINTS; /* DB 전체 시스템의, 모든 제약 조건 조회 ( CON$ 테이블 기반 VIEW ) */


SELECT *
FROM dba_tab_columns
WHERE table_name = 'EMPLOYEES'; /* DB 內 모든 테이블의 컬럼 정보(데이터 타입, 길이, NULL 여부 등) ( COL$ 테이블 기반 VIEW ) */


SELECT *
FROM SYS.CON$ /* 제약 조건(Constraints)의 고유 이름과 시스템 ID가 매핑된 원본 TABLE ( DBA_CONSTRAINTS 뷰와, USER_CONSTRAINTS 뷰의 원본 TABLE ) */


CREATE TABLE HR.DW_EMP
TABLESPACE users
AS
SELECT employee_id, last_name, salary, department_id
FROM HR.EMPLOYEES
WHERE department_id = 20;


CREATE TABLE HR.OLTP_EMP
TABLESPACE users
AS
SELECT employee_id, last_name, salary, department_id
FROM HR.EMPLOYEES;
select * from hr.DW_EMP;
SELECT * FROM HR.OLTP_EMP;


