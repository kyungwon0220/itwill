--[문제53] 부서이름별 급여의 총액, 평균을 구하세요. ( 일반적, INLINE VIEW, SCALAR SUBQUERY )
SELECT d.department_name, SUM(e.salary), ROUND(AVG(e.salary), 2)
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY 1 DESC;

SELECT d.department_name, SUM(e.salary), ROUND(AVG(e.salary), 2)
FROM HR.EMPLOYEES e
JOIN HR.DEPARTMENTS d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY 1 DESC;

SELECT d.department_name, e.sum_sal, e.avg_sal
FROM HR.DEPARTMENTS d,
        ( SELECT department_id, SUM(salary) AS sum_sal, ROUND(AVG(salary), 2) AS avg_sal /* INLINE VIEW 방식 ( 조인의 일량을 줄일수 있는 예제 ) */
            FROM HR.EMPLOYEES
            GROUP BY department_id ) e
WHERE e.department_id = d.department_id
ORDER BY 1 DESC;

SELECT
    department_name,
    ( SELECT SUM(salary) /* Scalar Subquery 방식 ( 단일행 단일값 리턴해야기에, Scalar Subquery 2회 작성 ) */
        FROM HR.EMPLOYEES
        WHERE department_id = d.department_id ) sum_sal, /* ' department_id ' 컬럼은, 중복값이 없기에, 캐시 장점 효과가 없다고 본다 */
    ( SELECT ROUND(AVG(salary),2)
        FROM HR.EMPLOYEES
        WHERE department_id = d.department_id ) avg_sal
FROM HR.DEPARTMENTS d;

SELECT
    department_name,
    ( SELECT '합: ' || SUM(salary) || ' , 평균: ' || ROUND(AVG(salary),2)
        FROM HR.EMPLOYEES
        WHERE department_id = d.department_id ) sal /* Scalar Subquery 1회 작성 방식 */
FROM HR.DEPARTMENTS d;

SELECT department_name, SUBSTR(sal, 1, 10), SUBSTR(sal, 11)
FROM (
    SELECT department_name,
            (SELECT LPAD(SUM(salary), 10) || LPAD(ROUND(AVG(salary),2),10) /* 결과 출력 열을 분할(원하는 모습으로 가공)*/
                FROM HR.EMPLOYEES
                WHERE department_id = d.department_id ) sal
    FROM HR.DEPARTMENTS d
)
WHERE sal IS NOT NULL;

--[문제54] 사원들의 last_name, salary, grade_level을 출력해주세요. ( JOIN, SCALAR SUBQUERY )
SELECT e.last_name, e.salary, j.grade_level
FROM HR.EMPLOYEES e, HR.JOB_GRADES j
WHERE  e.salary BETWEEN j.lowest_sal AND highest_sal;

SELECT last_name, salary, grade_level
FROM HR.EMPLOYEES e
JOIN HR.JOB_GRADES j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

SELECT last_name, salary,
        (SELECT grade_level
            FROM HR.JOB_GRADES
            WHERE e.salary BETWEEN lowest_sal AND highest_sal)
FROM HR.EMPLOYEES e;

--[문제55] 사원들의 employee_id, last_name을 출력을 하는데 단 department_name을 기준으로 오름차순 정렬해주세요. ( JOIN, SCALAR SUBQUERY )
SELECT e.employee_id, e.last_name, d.department_id
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.department_id = d.department_id(+) /* 키값이 안맞으면 결과 안나옴 */
ORDER BY d.department_name;

SELECT employee_id, last_name, d.department_id
FROM HR.DEPARTMENTS d
RIGHT OUTER JOIN HR.EMPLOYEES e
ON e.department_id = d.department_id
ORDER BY department_name;

SELECT e.employee_id, e.last_name, department_id
FROM HR.EMPLOYEES e
ORDER BY (SELECT department_name /* Scalar Subquery 방식 */
            FROM HR.DEPARTMENTS
            WHERE department_id = e.department_id );
