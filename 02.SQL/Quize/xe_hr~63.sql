--[문제60] 년도 분기별 총액을 구하세요. 행의 합과 열의 합도 구하세요.
--- - - - - - - - - -
--년도 1분기 2분기 3분기 4분기 합
--- - - - - - - - - -
--2001 17000       17000
--2002   36808 21008 11000 68816
--2003   35000 8000 3500 46500
--2004 40700 14300 17000 14000 86000
--2005 86900 16800 60800 33400 197900
--2006 69400 20400 14200 17100 121100
--2007 36600 20200 2500 35600 94900
--2008 46900 12300     59200
--  297500  155808 123508 114600 691416
--- - - - - - - - - -
SELECT
    year, /* 축 */
    MAX(DECODE(quarter, 1, sumsal)) "1분기",
    MAX(DECODE(quarter, 2, sumsal)) "2분기",
    MAX(DECODE(quarter, 3, sumsal)) "3분기",
    MAX(DECODE(quarter, 4, sumsal)) "4분기",
    MAX(DECODE(quarter, NULL, sumsal)) "합"
FROM (
    SELECT TO_CHAR(hire_date, 'yyyy') AS year, TO_CHAR(hire_date, 'Q') AS quarter, SUM(salary) sumsal
    FROM HR.EMPLOYEES
    GROUP BY CUBE(TO_CHAR(hire_date, 'yyyy'), TO_CHAR(hire_date, 'Q'))
)
GROUP BY year
ORDER BY year;

SELECT *
FROM (SELECT year, NVL(quarter, 0) AS quarter, sumsal /* INLINE VIEW 2 */
        FROM (SELECT TO_CHAR(hire_date, 'yyyy') AS year, TO_CHAR(hire_date, 'Q') AS quarter, SUM(salary) sumsal /* INLINE VIEW 1 */
                FROM HR.EMPLOYEES
                GROUP BY CUBE(TO_CHAR(hire_date, 'yyyy'), TO_CHAR(hire_date, 'Q'))
                )
)
PIVOT( MAX(sumsal) FOR quarter IN( 1 "1분기", 2 "2분기", 3 "3분기", 4 "4분기", 0 "합" ) )
ORDER BY year;

--[문제61] SELECT문을 이용해서 1~100출력해주세요
SELECT LEVEL /* LEVEL == 트리 층을 나타내는 가상 테이블 */
FROM DUAL
CONNECT BY LEVEL <= 100;

--[문제62] SELECT문을 이용해서 2단을 출력해주세요
SELECT '2 * ' || LEVEL || ' = ' || LEVEL * 2 AS "2단"
FROM DUAL
CONNECT BY LEVEL <= 9;

--[문제63] SELECT문을 이용해서 2단 ~ 9단 출력해주세요
SELECT dan || ' * ' || num || ' = ' || dan*num AS "구구"
FROM (SELECT LEVEL + 1 dan
        FROM DUAL
        CONNECT BY LEVEL <= 8),
        (SELECT LEVEL num /* 카티시안 곱이 발생 */
            FROM DUAL
            CONNECT BY LEVEL <= 9);
