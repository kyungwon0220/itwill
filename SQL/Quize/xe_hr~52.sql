--[문제46] 소속사원이 있는 부서정보를 출력해주세요.
SELECT *
FROM HR.DEPARTMENTS o
WHERE EXISTS ( SELECT NULL /* 문법 오류 방지 */
                FROM HR.EMPLOYEES
                WHERE department_id = o.department_id);

--[문제47] 소속사원이 없는 부서정보를 출력해주세요.
SELECT *
FROM HR.DEPARTMENTS o
WHERE NOT EXISTS ( SELECT NULL /* 문법 오류 방지 */
                    FROM HR.EMPLOYEES
                    WHERE department_id = o.department_id);

--[문제48] 사원들의 급여 등급에 포함된 등급정보를 출력해주세요.
SELECT *
FROM HR.JOB_GRADES
WHERE grade_level IN ( SELECT j.grade_level
                        FROM HR.JOB_GRADES j, HR.EMPLOYEES e
                        WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal);
                        
SELECT *
FROM HR.JOB_GRADES j
WHERE EXISTS ( SELECT NULL
                FROM HR.EMPLOYEES
                WHERE salary BETWEEN j.lowest_sal AND j.highest_sal);

--[문제49] 사원들의 급여 등급에 포함되지 않은 등급정보를 출력해주세요.
SELECT *
FROM HR.JOB_GRADES
WHERE grade_level NOT IN ( SELECT j.grade_level
                            FROM HR.JOB_GRADES j, HR.EMPLOYEES e
                            WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal);

SELECT *
FROM HR.JOB_GRADES j
WHERE NOT EXISTS ( SELECT NULL
                    FROM HR.EMPLOYEES
                    WHERE salary BETWEEN j.lowest_sal AND j.highest_sal);
