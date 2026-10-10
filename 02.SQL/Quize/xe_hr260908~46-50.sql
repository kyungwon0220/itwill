--[문제46] 소속사원이 있는 부서정보를 출력해주세요.
SELECT *
FROM HR.DEPARTMENTS
WHERE department_id IN ( SELECT department_id FROM HR.EMPLOYEES WHERE department_id IS NOT NULL );

SELECT *
FROM HR.DEPARTMENTS o
WHERE EXISTS ( SELECT NULL /* 문법상 아무자 작성 */ FROM HR.EMPLOYEES WHERE department_id = o.department_id );

--[문제47] 소속사원이 없는 부서정보를 출력해주세요.
SELECT *
FROM HR.DEPARTMENTS
WHERE department_id NOT IN ( SELECT department_id FROM HR.EMPLOYEES WHERE department_id IS NOT NULL );

--[문제48] 사원들의 급여 등급에 포함된 등급정보를 출력해주세요.
SELECT * FROM HR.JOB_GRADES;
SELECT *
FROM HR.JOB_GRADES
WHERE grade_level IN ( SELECT j.grade_level
                        FROM HR.JOB_GRADES j, HR.EMPLOYEES e
                        WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal);
                        
SELECT *
FROM HR.JOB_GRADES j
WHERE EXISTS ( SELECT NULL FROM HR.EMPLOYEES WHERE salary BETWEEN j.lowest_sal AND j.highest_sal);                        

--[문제49] 사원들의 급여 등급에 포함되지 않은 등급정보를 출력해주세요.
SELECT *
FROM HR.JOB_GRADES j
WHERE grade_level NOT IN ( SELECT NULL FROM HR.EMPLOYEES WHERE salary BETWEEN j.lowest_sal AND j.highest_sal );

--[문제50] 부서별로 인원수를 출력주세요.
--        10         20         30         40         50         60         70         80         90        100        110 부서가 없는 사원
------------ ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------------
--         1          2          6          1         45          5          1         34          3          6          2                1
SELECT SUM(DECODE(department_id, 10, 1)) AS "10"
FROM HR.EMPLOYEES;

SELECT MAX(DECODE(department_id, 10, CNT)) AS "100"
FROM ( SELECT department_id, count(*) CNT
        FROM HR.EMPLOYEES
        GROUP BY department_id
        ORDER BY department_id
    );
