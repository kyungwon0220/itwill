--[문제1] demployees 테이블에서 employee_id, last_name과 first_name은 연결해서 표시하고(공백으로 구분) 열 별칭은 화면 예처럼 쿼리문을 작성해 주세요.
SELECT
    employee_id "Emp#",
    last_name || ' ' || first_name AS "Employee Name"
FROM HR.EMPLOYEES;

--[문제2] employees 테이블에서 컬럼중에 last_name, job_id를 연결해서 표시하고(쉼표와 공백으로 구분) 열 별칭은 화면 예처럼 쿼리문을 작성해 주세요.
SELECT
    last_name || ', ' || job_id || q'[. TestText]' AS "Employee and Title"
FROM HR.EMPLOYEES;
