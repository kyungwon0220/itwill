--[문제36] 2006년도에 입사한 사원들의 부서이름별 급여의 총액, 평균을 출력해주세요. ( 오라클 전용, ANSI 표준 )
SELECT d.department_id, d.department_name, SUM(e.salary), AVG(e.salary)
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.department_id = d.department_id AND
--TO_CHAR(e.hire_date, 'yyyy') = '2006'
e.hire_date >= TO_DATE('2006-01-01', 'yyyy-mm-dd') AND e.hire_date < TO_DATE('2007-01-01', 'yyyy-mm-dd')
GROUP BY d.department_id, d.department_name
ORDER BY 1 DESC;

SELECT d.department_id, d.department_name, SUM(e.salary), AVG(e.salary)
FROM HR.EMPLOYEES e
JOIN HR.DEPARTMENTS d
ON e.department_id = d.department_id
--WHERE TO_CHAR(e.hire_date, 'yyyy') = '2006'
WHERE e.hire_date >= TO_DATE('2006-01-01', 'yyyy-mm-dd') AND e.hire_date < TO_DATE('2007-01-01', 'yyyy-mm-dd')
GROUP BY d.department_id, d.department_name
ORDER BY 1 DESC;

--[문제37] 사원들의 last_name,salary,grade_level, department_name을 출력하는데 last_name에 a문자가 2개 이상 포함되어 있는 사원들을 출력하세요. ( 오라클 전용, ANSI 표준 )
--SELECT e.last_name, e.salary, j.grade_level, d.department_name /* 답안 체크 필요 ( 결과가 다르게 출력? )*/
--FROM HR.EMPLOYEES e, HR.DEPARTMENTS d, HR.JOB_GRADES j
--WHERE e.last_name LIKE '%a%a'
--    AND e.salary BETWEEN j.lowest_sal AND j.highest_sal
--    AND e.department_id = d.department_id;
    
SELECT e.last_name, e.salary, j.grade_level, d.department_name
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d, HR.JOB_GRADES j
WHERE INSTR(e.last_name, 'a', 1, 2) >= 2
    AND e.salary BETWEEN  j.lowest_sal AND j.highest_sal
    AND e.department_id = d.department_id;

SELECT e.last_name, e.salary, j.grade_level, d.department_name
FROM HR.EMPLOYEES e
JOIN HR.DEPARTMENTS d /* ANSI 표준 방식의 문법 */
ON e.department_id = d.department_id
JOIN HR.JOB_GRADES j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal
WHERE INSTR(e.last_name, 'a', 1, 2) >= 2;

--[문제38] 담당 관리자보다 먼저 입사한 사원의 이름과 입사일 및 해당 관리자의 이름과 입사일 출력해주세요. ( 오라클 전용, ANSI 표준 )
SELECT w.employee_id, w.last_name, w.hire_date, m.employee_id, m.last_name, m.hire_date
FROM HR.EMPLOYEES w, HR.EMPLOYEES m
WHERE w.manager_id = m.employee_id
    AND w.hire_date < m.hire_date;

SELECT w.employee_id, w.last_name, w.hire_date, m.employee_id, m.last_name, m.hire_date
FROM HR.EMPLOYEES w
JOIN HR.EMPLOYEES m /* ANSI 표준 방식의 문법 */
ON w.manager_id = m.employee_id
WHERE w.hire_date < m.hire_date;

--[문제39] 110번 사원의 job_id와 동일한 사원들 중에 110번 사원의 급여보다 더 많이 받는 사원들의 정보를 추출하세요
SELECT *
FROM HR.EMPLOYEES
WHERE job_id = (SELECT job_id
                FROM HR.EMPLOYEES
                WHERE employee_id = 110) AND
        salary > (SELECT salary
                    FROM HR.EMPLOYEES
                    WHERE employee_id = 110);

--[문제40] 최고 급여를 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE salary = (SELECT MAX(salary)
                FROM HR.EMPLOYEES);
                
--[문제41] 2006년도에 입사한 사원들의 job_id와 동일한 사원들의 job_id별 급여의 총액 중에 50000 이상인 값만 출력해주세요.
SELECT job_id, SUM(salary)
FROM HR.EMPLOYEES
WHERE job_id IN (SELECT job_id /* Subquery 결과가, 단일행이 아니기에, 여러 행 비교 연산자 사용 */
                    FROM HR.EMPLOYEES
                    WHERE hire_date >= TO_DATE('2006-01-01', 'yyyy-mm-dd')
                    AND hire_date < TO_DATE('2007-01-01' ,'yyyy-mm-dd'))
GROUP BY job_id
HAVING SUM(salary) >= 50000
ORDER BY 2 DESC;

--[문제42] location_id 가 1700인 모든 사원들의 last_name, department_id, job_id를 출력해주세요. ( 조인, 서브 쿼리 )
SELECT e.last_name, d.department_id, e.job_id
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.department_id = d.department_id AND d.location_id = 1700;

SELECT e.last_name, d.department_id, e.job_id
FROM HR.EMPLOYEES e
JOIN HR.DEPARTMENTS d /* ANSI 표준 방식 JOIN 문법 */
ON e.department_id = d.department_id
WHERE d.location_id = 1700;

SELECT e.last_name, department_id, e.job_id /* /* USING 절에서 기준으로 사용한 컬럼명은 테이블명 없이 사용 */
FROM HR.EMPLOYEES e
JOIN HR.DEPARTMENTS d  /* ANSI 표준 방식 JOIN 문법 */
USING (department_id)
WHERE d.location_id = 1700;

SELECT last_name, department_id, job_id
FROM HR.EMPLOYEES
WHERE department_id IN (SELECT department_id
                            FROM HR.DEPARTMENTS
                            WHERE location_id = 1700); /* Subquery 구현해도, 오라클에서 자동으로 JOIN 변환 (차후, 문장 튜닝 진도에서 배울 예정) */
                            
--[문제43] 60번 부서 사원들중 최대 급여보다 더 많은 급여를 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE salary > ( SELECT MAX(salary)
                    FROM HR.EMPLOYEES
                    WHERE department_id = 60 )
ORDER BY salary DESC;

SELECT *
FROM HR.EMPLOYEES
WHERE salary > ALL(SELECT salary
                    FROM HR.EMPLOYEES
                    WHERE department_id = 60)
ORDER BY salary DESC;

--[문제44] 관리자 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE employee_id IN(SELECT manager_id
                        FROM HR.EMPLOYEES)
ORDER BY employee_id DESC;

--[문제45] 관리자가 아닌 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE employee_id NOT IN(SELECT manager_id
                            FROM HR.EMPLOYEES
                            WHERE manager_id IS NOT NULL) /* NOT IN 연산자 사용시, AND 진리표로 구현되기에 NULL 값 제외 필요 */
ORDER BY employee_id DESC;
