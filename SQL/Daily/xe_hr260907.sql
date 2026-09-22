select l.* /* NATURAL JOIN 처리된 컬럼은, 테이블명을 붙일시 ERR */
from hr.departments d NATURAL JOIN hr.locations l;


SELECT e.employee_id, l.city, department_id /* USING 절에서 기준으로 사용한 컬럼명은 테이블명 없이 사용 ( ' d.department_id ' 식으로, 테이블명 지정시 ERR 발생 ) */
FROM hr.employees e JOIN hr.departments d
USING (department_id)
JOIN hr.locations l /* 상위 JOIN 결과 집합으로, hr.locations 테이블 JOIN */
USING (location_id)
WHERE department_id IN(20, 30, 50); /* USING 절에서 기준으로 사용한 컬럼명은, 테이블명 없이 사용 */

SELECT *
FROM HR.EMPLOYEES
--WHERE salary > (SELECT salary
--                FROM HR.EMPLOYEES
--                WHERE last_name = 'King'); /* Subquery 결과가, 단일행이 아니어서 비교가 불가하여 ERR 발생 */
WHERE salary > (SELECT MAX(salary) /* Subquery 결과 == 단일행 */
                FROM HR.EMPLOYEES
                WHERE last_name = 'King');


SELECT department_id, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY department_id
HAVING SUM(salary) = (SELECT MAX(SUM(salary)) /* Subquery 결과 == 단일행 */
                        FROM HR.EMPLOYEES
                        GROUP BY department_id);


SELECT *
FROM HR.EMPLOYEES
WHERE salary IN (SELECT salary
                    FROM HR.EMPLOYEES
                    WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary IN (4200, 4800, 6000, 9000)
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary = 4200 OR salary = 4800 OR salary = 6000 OR salary = 9000
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary > ANY(SELECT salary
                    FROM HR.EMPLOYEES
                    WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary > 4200 OR salary > 4800 OR salary > 6000 OR salary > 9000
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary > ALL(SELECT salary
                    FROM HR.EMPLOYEES
                    WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary > (SELECT MAX(salary) /* 이번 예제, ALL 대체 가능 */
                    FROM HR.EMPLOYEES
                    WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;


SELECT *
FROM HR.EMPLOYEES
WHERE salary > 4200 AND salary > 4800 AND salary > 6000 AND salary > 9000
ORDER BY salary DESC;


select *
from hr.employees o /* Main 쿼리절의 테이블에 별칭 지정 */
where salary > (select avg(salary)
                from hr.employees
                where department_id = o.department_id); /* 상호 관련 서브 쿼리 */ /* o.department_id == 후보행 값 */


SELECT e1.*, e2.*
FROM (SELECT department_id, ROUND(AVG(salary), 2) AS "부서별 급여 평균" /* INLINE VIEW */
        FROM HR.EMPLOYEES
        GROUP BY department_id) e1,
    HR.EMPLOYEES e2
WHERE e1.department_id = e2.department_id AND e1."부서별 급여 평균" < e2.salary
ORDER BY e2.salary DESC;


SELECT e1.*, e2.*
FROM (SELECT department_id, ROUND(AVG(salary), 2) AS "부서별 급여 평균" /* INLINE VIEW */
        FROM HR.EMPLOYEES
        GROUP BY department_id) e1
JOIN HR.EMPLOYEES e2 /* ANSI 표준 방식 문법 */
ON e1.department_id = e2.department_id
WHERE e2.salary > e1."부서별 급여 평균"
ORDER BY e2.salary DESC;
