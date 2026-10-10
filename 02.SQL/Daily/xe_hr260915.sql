CREATE OR REPLACE VIEW HR.COPY_EMP
AS
SELECT employee_id, last_name || ' ' || first_name AS "name", /* 표현식 사용시, 별칭 지정 필수 */
FROM HR.EMP
WITH READ ONLY; /* ' WITH READ ONLY ' == DML 불허 */


INSERT INTO HR.COPY_EMP(job, mgr, dept_id)
SELECT job_id, manager_id, department_id /* INSERT SubQuery */
FROM HR.EMPLOYEES
WHERE employee_id <> 202;


UPDATE HR.COPY_EMP
SET SALARY = 999
WHERE "name" = 'Taylor Winston'; /* 뷰를 통해서, 가공된 표현식으로 UPDATE 가능 */


DELETE FROM HR.COPY_EMP
WHERE "name" = 'Taylor Winston'; /* 뷰를 통해서, 가공된 표현식으로 DELETE 가능 */


DROP VIEW HR.COPY_EMP; /* VIEW 삭제 */


CREATE OR REPLACE VIEW HR.COPY_EMP
AS
SELECT last_name || ' ' || first_name, /* 가공된 ' name ' 컬럼에는 INSERT 불가 */
        first_name /* 가공식이 아닌, ' first_name ' 컬럼을 직접 SELECT 경우에는 INSERT 가능 */
FROM HR.EMP;

    
INSERT INTO HR.COPY_EMP(first_name, last_name) /* ' last_name ' 컬럼은 뷰의 SELECT 문에 없기에, INSERT 불가 ERR */
VALUES('Winston', 'Taylor');


UPDATE HR.COPY_EMP
SET SALARY = 999
WHERE last_name = 'Taylor'; /* ' last_name ' 컬럼은 뷰의 SELECT 문에 없기에, UPDATE 불가 ERR */


DELETE FROM HR.COPY_EMP
WHERE last_name = 'Taylor'; /* ' last_name ' 컬럼은 뷰의 SELECT 문에 없기에, DELETE 불가 ERR */


CREATE TABLE HR.EMP ( first_name VARCHAR(50), /* 원본 테이블 예시 */
                        last_name VARCHAR(50),
                        salary NUMBER,
                        email VARCHAR(255) NOT NULL );


INSERT INTO HR.COPY_EMP(first_name, last_name) /* 뷰의 SELECT 문에 ' email ' 컬럼이 없는데, NOT NULL 제약 조건이 걸려 있으며 DEFAULT 값도 없으므로, 뷰를 통한 INSERT 작업 불가 ERR */
VALUES('William', 'KW'); 


CREATE OR REPLACE VIEW HR.EMP_20
AS
SELECT *
FROM HR.EMP
WHERE dept_id = 20 /* CHECK 제약 조건의, 조건식*/
WITH CHECK OPTION CONSTRAINT emp_20_ck; /* ' emp_20_ck ' 이름으로, CHECK 제약 조건 생성, 적용 */


INSERT INTO HR.EMP_20(salary, dept_id)
VALUES(9999, NULL); /* ' dept_id = 20 ' CHECK 제약 조건 위반으로, INSERT 불가 ERR */


UPDATE HR.EMP_20
SET dept_id = 10 /* CHECK 제약 조건 위반으로, UPDATE 불가 ERR */
WHERE "name" = 'Taylor Winston';


CREATE SEQUENCE ID_SEQ
START WITH 1 /* ' START WITH ' 미설정시, 기본값은 1 */
MAXVALUE 10 /* ' MAXVALUE ' 미설정시, 기본값은 10의 27승 */
INCREMENT BY 1 /* ' INCREMENT BY ' 미설정시, 기본값은 1 */
NOCYCLE /* 기본값 ' NOCYCLE ' */
NOCACHE; /* 기본값은 CACHE == 20 */


SELECT *
FROM USER_SEQUENCES /* 현재 접속한 사용자가(본인) 소유한 SEQUENCES 정보 */
WHERE SEQUENCE_NAME = 'ID_SEQ';


DROP TABLE HR.EMP CASCADE CONSTRAINTS PURGE;
CREATE TABLE HR.EMP(id number, name varchar2(30), day timestamp) TABLESPACE users;


INSERT INTO HR.EMP(id, name)
VALUES(ID_SEQ.NEXTVAL, /* ' NEXTVAL ' == 실제 컬럼이 아닌, 의사 열 ( 가상 컬럼 == pseudo COLUMN ) */
        'Taylor Winston');


SELECT ID_SEQ.CURRVAL
FROM DUAL; /* ' CURRVAL ' == 가상 컬럼 == 현재까지 사용한 마지막 번호 ( ' NEXTVAL ' 사용 이력이 없다면, 조회 불가 ERR ) */


SELECT ID_SEQ.NEXTVAL /* ' NEXTVAL ' 사용함으로 처리되어 CURRVAL + 1 증가 (' SELECT * FROM ALL_SEQUENCES ' 수행시, ' LAST_NUMBER ' + 1 증가 ) */
FROM DUAL;


ALTER SEQUENCE ID_SEQ /* ' START WITH ' 제외한, 다른 옵션들은 수정 가능 */
INCREMENT BY 1;


DROP SEQUENCE ID_SEQ; /* 시퀀스 삭제 */
