--[문제59] UNION ALL, ROULLUP
--1) department_id, job_id, manager_id 기준으로 총액 급여를 출력
--2) department_id, job_id 기준으로 총액급여를 출력
--3) department_id 기준으로 총액급여를 출력
--4) 전체 총액 급여를 출력
--1),2),3),4)를 한꺼번에 출력해주세요.

SELECT department_id, job_id, manager_id, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY department_id, job_id, manager_id
UNION ALL
SELECT department_id, job_id, NULL, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY department_id, job_id
UNION ALL
SELECT department_id, NULL, NULL, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY department_id
UNION ALL
SELECT NULL, NULL, NULL, SUM(salary)
FROM HR.EMPLOYEES;

SELECT department_id, job_id, manager_id, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY ROLLUP(department_id, job_id, manager_id);
