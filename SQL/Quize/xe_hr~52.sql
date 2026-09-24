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

--[문제50] 부서별로 인원수를 출력주세요.
--        10         20         30         40         50         60         70         80         90        100        110 부서가 없는 사원
------------ ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------------
--         1          2          6          1         45          5          1         34          3          6          2                1
SELECT COUNT(DECODE(department_id, 10, 'x')) AS "10",
        COUNT(DECODE(department_id, 20, 'x')) AS "20",
        COUNT(DECODE(department_id, 30, 'x')) AS "30",
        COUNT(DECODE(department_id, 40, 'x')) AS "40",
        COUNT(DECODE(department_id, 50, 'x')) AS "50",
        COUNT(DECODE(department_id, 60, 'x')) AS "60",
        COUNT(DECODE(department_id, 70, 'x')) AS "70",
        COUNT(DECODE(department_id, 80, 'x')) AS "80",
        COUNT(DECODE(department_id, 90, 'x')) AS "90",
        COUNT(DECODE(department_id, 100, 'x')) AS "100",
        COUNT(DECODE(department_id, 110, 'x')) AS "110",
        COUNT(DECODE(department_id, NULL, 'x')) AS "부서가 없는 사원"
FROM HR.EMPLOYEES;

SELECT
    MAX(DECODE(department_id, 10, cnt)) AS "10",
    MAX(DECODE(department_id, 20, cnt)) AS "20",
    MAX(DECODE(department_id, 30, cnt)) AS "30",
    MAX(DECODE(department_id, 40, cnt)) AS "40",
    MAX(DECODE(department_id, 50, cnt)) AS "50",
    MAX(DECODE(department_id, 60, cnt)) AS "60",
    MAX(DECODE(department_id, 70, cnt)) AS "70",
    MAX(DECODE(department_id, 80, cnt)) AS "80",
    MAX(DECODE(department_id, 90, cnt)) AS "90",
    MAX(DECODE(department_id, 100, cnt)) AS "100",
    MAX(DECODE(department_id, 110, cnt)) AS "110",
    MAX(DECODE(department_id, NULL, cnt)) AS "부서가 없는 사원"
FROM (SELECT department_id, COUNT(*) AS cnt
        FROM HR.EMPLOYEES
        GROUP BY department_id);

--[문제51] 년도별 입사 인원수를 출력해주세요.
--       2001       2002       2003       2004       2005       2006
------------ ---------- ---------- ---------- ---------- ----------
--         1          7          6         10         29         24
SELECT *
FROM (SELECT TO_CHAR(hire_date, 'yyyy') year
        FROM HR.EMPLOYEES)
PIVOT( COUNT(*) FOR year IN ('2001', '2002', '2003', '2004', '2005', '2006', '2007', 2008) ); /* ' ' ' 따옴표를 쓰지 않으면, 암시적 형변환 발생 */

SELECT *
FROM (SELECT TO_CHAR(hire_date, 'yyyy') year, COUNT(*) cnt
        FROM HR.EMPLOYEES
        GROUP BY TO_CHAR(hire_date, 'yyyy'))
PIVOT( MIN(cnt) FOR year IN ('2001' AS "2001", '2002', '2003', '2004', '2005', '2006', '2007', 2008) );

--[문제52] 년도,분기별 급여의 총액을 구하세요.
--년도          1분기      2분기      3분기      4분기
---------- ---------- ---------- ---------- ----------
--2001          17000
--2002                     36808      21008      11000
--2003                     35000       8000       3500
--2004          40700      14300      17000      14000
--2005          86900      16800      60800      33400
--2006          69400      20400      14200      17100
--2007          36600      20200       2500      35600
--2008          46900      12300
SELECT *
FROM (SELECT TO_CHAR(hire_date, 'yyyy') AS "년도", TO_CHAR(hire_date, 'Q') Q, salary /* PIVOT() 에서 선택되지 않은 year == 세로축이 된다 */
        FROM HR.EMPLOYEES
        )
PIVOT( SUM(salary) FOR Q IN ('1' AS "1분기", '2' AS "2분기", '3' "3분기", 4 "4분기") )
ORDER BY 1 DESC;

SELECT *
FROM (SELECT TO_CHAR(hire_date, 'yyyy') AS "년도", TO_CHAR(hire_date, 'Q') Q, SUM(salary) sum_salary /* PIVOT() 에서 선택되지 않은 year == 세로축이 된다 */
        FROM HR.EMPLOYEES
        GROUP BY TO_CHAR(hire_date, 'yyyy'), TO_CHAR(hire_date, 'Q') /* 분기별로 SUM() */
        )
PIVOT( MAX(sum_salary) FOR Q IN ('1' AS "1분기", '2' AS "2분기", '3' "3분기", 4 "4분기") )
ORDER BY 1 DESC;
