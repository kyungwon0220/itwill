SELECT department_id, COUNT(*) AS cnt
        FROM HR.EMPLOYEES
        GROUP BY department_id
        ORDER BY department_id;
        
        
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


SELECT *
FROM ( SELECT department_id dept_id /* 별칭 지정시, PIVOT() 내에서 별칭으로만 사용 가능 ( ' department_id ' 컬럼명 사용시 ERR 발생 ) */
        FROM HR.EMPLOYEES)
PIVOT ( COUNT(*) FOR dept_id IN(10 "10번 부서", 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, NULL AS "부서가 없는 사원") ),
(SELECT COUNT(*) 총인원수 FROM HR.EMPLOYEES);


SELECT *
FROM (SELECT department_id dept_id, COUNT(*) cnt
        FROM HR.EMPLOYEES
        GROUP BY department_id)
PIVOT ( MAX(cnt) FOR dept_id IN(10 "10번 부서", 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, NULL AS "부서가 없는 사원") ),
(SELECT COUNT(*) 총인원수 FROM HR.EMPLOYEES);


SELECT *
FROM (SELECT TO_CHAR(hire_date, 'yyyy') AS "year", TO_CHAR(hire_date, 'Q') Q, salary /* PIVOT() 에서 선택되지 않은 year == 세로축이 된다 */
        FROM HR.EMPLOYEES
        )
PIVOT( SUM(salary) FOR Q IN ('1' AS "1분기", '2' AS "2분기", '3' "3분기", 4 "4분기") )
ORDER BY 1 DESC;


SELECT *
FROM(
    SELECT *
    FROM (SELECT TO_CHAR(hire_date, 'yyyy') AS "year", TO_CHAR(hire_date, 'Q') Q, salary /* PIVOT() 에서 선택되지 않은 year == 세로축이 된다 */
            FROM HR.EMPLOYEES
            )
    PIVOT( SUM(salary) FOR Q IN ('1' AS "1분기", '2' AS "2분기", '3' "3분기", 4 "4분기") )
)
UNPIVOT INCLUDE NULLS ( 총급여액 FOR 분기 IN ("1분기", "2분기", "3분기", "4분기") ) /* INCLUDE NULLS == NULL 값도 생략없이 출력 */
ORDER BY 1 DESC, 2 DESC;


SELECT *
FROM (
    SELECT *
    FROM ( SELECT TO_CHAR(hire_date, 'dy') week
            FROM HR.EMPLOYEES )
    PIVOT( COUNT(*) FOR week IN ('월' AS "월", '화' AS 화, '수' 수, '목' "목", '금' "금", '토' "토", '일' "일") )
)
UNPIVOT( 인원수 FOR 요일 IN (월, 화, 수, 목, 금, 토, 일) );


SELECT *
FROM HR.EMPLOYEES
WHERE (manager_id, department_id) IN ( SELECT manager_id, department_id /* first_name == John 사원들이 가진 manager_id, department_id 쌍으로 추출 */
                                        FROM HR.EMPLOYEES
                                        WHERE first_name = 'John' );


SELECT *
FROM HR.EMPLOYEES
WHERE manager_id IN( SELECT manager_id
                        FROM HR.EMPLOYEES
                        WHERE first_name = 'John')
    AND /* 비쌍비교 ( 각각 추출한 ' manager_id ', ' department_id ' 만족하는지 ) */
        department_id IN (SELECT department_id
                            FROM HR.EMPLOYEES
                            WHERE first_name = 'John');
