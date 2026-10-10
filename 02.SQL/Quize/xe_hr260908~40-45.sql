--[문제40] 최고 급여를 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES e
WHERE salary = (SELECT MAX(salary) FROM HR.EMPLOYEES);

--[문제41] 2006년도에 입사한 사원들의 job_id와 동일한 사원들의 job_id별 급여의 총액 중에 50000 이상인 값만 출력해주세요.
SELECT job_id, SUM(salary)
FROM HR.EMPLOYEES
WHERE job_id IN (
    SELECT job_id
    FROM HR.EMPLOYEES
    WHERE hire_date BETWEEN TO_DATE ('2006-01-01') AND TO_DATE('2006-12-31'))
GROUP BY job_id
HAVING SUM(salary) >= 50000;

--[문제42] location_id 가 1700인 모든 사원들의 last_name, department_id, job_id를 출력해주세요. ( 조인, 서브 쿼리 )
SELECT e.last_name, e.department_id, e.job_id
FROM HR.EMPLOYEES e
JOIN  HR.DEPARTMENTS d  ON e.department_id = d.department_id
WHERE d.location_id = 1700;

SELECT last_name, department_id, job_id
FROM HR.EMPLOYEES 
WHERE department_id IN ( SELECT department_id FROM HR.DEPARTMENTS WHERE location_id IN 1700);

--[문제43] 60번 부서 사원들중 최대 급여보다 더 많은 급여를 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE salary > ( SELECT MAX(salary) FROM HR.EMPLOYEES WHERE department_id = 60 );

--[문제44] 관리자 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES e, HR.EMPLOYEES m
WHERE e.manager_id = m.employee_id;

SELECT *
FROM HR.EMPLOYEES
WHERE employee_id IN (  SELECT manager_id FROM HR.EMPLOYEES);

--[문제45] 관리자가 아닌 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE employee_id NOT IN ( SELECT manager_id FROM HR.EMPLOYEES WHERE manager_id IS NOT NULL);
