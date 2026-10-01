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


SELECT *
FROM USER_UNUSED_COL_TABS; /* ' SET UNUSED ' 처리한 컬럼의 개수 조회 */


SELECT *
FROM USER_CONS_COLUMNS; /* 컬럼별 제약 조건 조회 */


SELECT *
FROM USER_INDEXES; /* 현재 사용자가 소유한 인덱스 정보 조회 */


SELECT *
FROM USER_IND_COLUMNS; /* 인덱스를 구성하는 컬럼 정보 조회 */


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


MERGE INTO HR.DW_EMP d /* 타겟 (업데이트 되는 테이블) */
USING HR.OLTP_EMP o /* 소스 테이블 */
ON (d.employee_id = o.employee_id)
WHEN MATCHED THEN /* ON 절의 키 값이 일치시 */
    UPDATE SET d.salary = o.salary * 1.1
    DELETE WHERE o.FLAG = 'D'
WHEN NOT MATCHED THEN
    INSERT(d.employee_id, d.last_name, d.salary, d,deparmtnet_id)
    VALUES(o.employee_id, o.last_name, o.salary, o,deparmtnet_id);


ALTER TABLE HR.EMP
ADD job_id VARCHAR2(30); /* ' HR.EMP ' 테이블에 ' job_id ' 컬럼 추가 ( 모든 행의, 기본값은 NULL ) */


ALTER TABLE HR.EMP
MODIFY job_id VARCHAR2(40); /* VARCHAR2(40) 크기 수정 */


ALTER TABLE HR.EMP
DROP COLUMN job_id; /* ' job_id ' 컬럼 삭제 */


ALTER TABLE HR.EMP
SET UNUSED COLUMN job_id; /* ' job_id ' 컬럼 ' SET UNUSED ' 설정 ( ' SET UNUSED ' 설정시, 조회 불가 및 ' SET UNUSED ' 취소 불가 )*/


ALTER TABLE HR.EMP DROP UNUSED COLUMNS; /* ' SET UNUSED ' 처리한 컬럼 실삭제 */


ALTER TABLE HR.EMP
ADD CONSTRAINT emp_dept_id_fk /* ' emp_dept_id_fk ' 이름으로 FOREIGN KEY 생성 */
FOREIGN KEY(dept_id) /* ' HR.EMP.dept_id ' 컬럼을 지정 */
REFERENCES HR.DEPT(dept_id); /* ' HR.DEPT(dept_id) ' 內 존재하는 값 또는 NULL 입력 가능하게 */
-- ON DELETE RESTRICT (기본값) == ' HR.EMP.dept_id ' 컬럼에 데이터 존재시, ' HR.DEPT.dept_id '삭제 불가
-- ON DELETE CASCADE ==  ' HR.DEPT.dept_id '삭제시, ' HR.EMP.dept_id ' 컬럼 데이터들도 삭제
-- ON DELETE SET NULL == ' HR.DEPT.dept_id '삭제시, ' HR.EMP.dept_id ' 컬럼 값들을 ' NULL '


ALTER TABLE HR.EMP
ADD CONSTRAINT emp_id_pk PRIMARY KEY(id); /* ' emp_id_pk ' == 제약조건명,' id ' 컬럼에 제약 조건 설정*/


ALTER TABLE HR.EMP
ADD PRIMARY KEY(id); /* CONSTRANT_NAME 자동 생성 (제약 조건명 자동 생성) */


ALTER TABLE HR.EMP
DROP PRIMARY KEY; /* PRIMARY 키는 테이블당 1개로 유일하기에, 이렇게도 삭제 가능 */


ALTER TABLE HR.DEPT
DROP CONSTRAINT dept_pk CASCADE; /* ' dept_pk ' PK 참조중인, 외래키들 삭제 +  ' dept_pk ' PK 삭제 */


ALTER TABLE HR.EMP
ADD CONSTRAINT emp_dept_id_fk /* ' emp_dept_id_fk ' 이름으로 FOREIGN KEY 생성 */
FOREIGN KEY(dept_id) /* ' HR.EMP.dept_id ' 컬럼을 지정 */
REFERENCES HR.DEPT(dept_id); /* ' HR.DEPT(dept_id) ' 內 존재하는 값 또는 NULL 입력 가능하게 */
-- ON DELETE RESTRICT (기본값) == ' HR.EMP.dept_id ' 컬럼에 데이터 존재시, ' HR.DEPT.dept_id '삭제 불가
-- ON DELETE CASCADE ==  ' HR.DEPT.dept_id '삭제시, ' HR.EMP.dept_id ' 컬럼 데이터들도 삭제
-- ON DELETE SET NULL == ' HR.DEPT.dept_id '삭제시, ' HR.EMP.dept_id ' 컬럼 값들을 ' NULL '


DELETE FROM HR.DEPT WHERE dept_id = 10; /* 현재 emp_dept_id_fk 외래키가 ' ON DELETE RESTRICT (기본값) ' 생성되어 있기에, ' HR.EMP.dept_id ' == ' 10 ' 행이 존재시, DELETE 수행 불가 ERR 발생 */


DELETE FROM HR.DEPT WHERE dept_id = 120; /* 현재 emp_dept_id_fk 외래키가 ' ON DELETE RESTRICT (기본값) ' 생성되어 있지만, ' HR.EMP.dept_id ' == ' 120 ' 행이 없기에, DELETE 수행 가능 */


DROP TABLE HR.DEPT CASCADE CONSTRAINTS PURGE; /* ' HR.DEPT ' 참조하는, 외래키들 + ' HR.DEPT ' 테이블 삭제 */


ALTER TABLE HR.DEPT ADD CONSTRAINT dept_name_uk UNIQUE(dept_name);


INSERT INTO HR.DEPT(dept_id, dept_name) VALUES(30, '총무부'); /* 이미 ' dept_name ' == ' 총무부 ' 존재하여, INSERT 수행 불가 ERR */


ALTER TABLE HR.DEPT
DROP UNIQUE(dept_name); /* UNIQUE 조건은, 테이블당 하나가 아니므로 ' dept_name ' 컬럼명 기입 필수 */


ALTER TABLE HR.EMP
ADD CONSTRAINT emp_sal_ck
CHECK(sal>=1000 AND sal <= 2000);


ALTER TABLE HR.EMP
MODIFY name CONSTRAINT emp_name_nn NOT NULL; /* ' emp_name_nn ' == 제약 조건명 */


ALTER TABLE HR.EMP
MODIFY name NULL;


CREATE TABLE HR.EMP(
--   id NUMBER CONSTRAINT emp_id_pk PRIMARY KEY, /* 열 레벨 정의 */
   name VARCHAR2(30) CONSTRAINT emp_name_nn NOT NULL /* NOT NULL 제약 조건은, 반드시 ' 열 레벨 ' 정의 필수 */
                        CONSTRAINT emp_name_uk UNIQUE, /* 제약 조건 2개 적용 ( 열 레벨 정의 ) */ 
   sal NUMBER,
--   dept_id NUMBER CONSTRAINT emp_dept_id_fk REFERENCES HR.DEPT(dept_id),
   CONSTRAINT emp_id_pk PRIMARY KEY(id), /* 테이블 레벨 정의 */
--   CONSTRAINT emp_name_uk UNIQUE(name), /* 테이블 레벨 정의 */
   CONSTRAINT emp_sal_ck CHECK(sal BETWEEN 1000 AND 2000),
   CONSTRAINT emp_dept_id_fk FOREIGN KEY(dept_id) REFERENCES HR.DEPT(dept_id) /* 테이블 레벨 정의 */ )
TABLESPACE users;
