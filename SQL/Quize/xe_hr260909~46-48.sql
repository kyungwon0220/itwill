--[문제46] 소속사원이 있는 부서정보를 출력해주세요.
SELECT *
FROM HR.DEPARTMENTS
WHERE department_id IN ( SELECT department_id FROM HR.EMPLOYEES WHERE department_id IS NOT NULL );

SELECT *
FROM HR.DEPARTMENTS o
WHERE EXISTS ( SELECT NULL FROM HR.EMPLOYEES WHERE department_id = o.department_id );

--[문제47] 소속사원이 없는 부서정보를 출력해주세요.
SELECT *
FROM HR.DEPARTMENTS
WHERE department_id NOT IN ( SELECT department_id FROM HR.EMPLOYEES WHERE department_id IS NOT NULL );

--[문제48] 사원들의 급여 등급에 포함된 등급정보를 출력해주세요.
SELECT *
FROM HR.JOB_GRADES o
WHERE EXISTS ( SELECT NULL FROM HR.EMPLOYEES WHERE salary BETWEEN o.lowest_sal AND o.highest_sal );

SELECT *
FROM HR.JOB_GRADES
WHERE grade_level IN ( SELECT j.grade_level FROM HR.JOB_GRADES j, HR.EMPLOYEES e WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal );
