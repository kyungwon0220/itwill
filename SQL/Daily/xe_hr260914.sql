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

