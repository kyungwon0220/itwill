--22. 오늘 날짜를 출력해주세요
SELECT
    SYSDATE,
    TO_CHAR(sysdate,'fmyyyy') || '년 ' ||
    TO_CHAR(sysdate, 'mm') || '월 ' ||
    TO_CHAR(sysdate, 'dd') || '일 ',
    TO_CHAR(sysdate, 'dl'),
    TO_CHAR(sysdate, 'ds')
FROM dual;

--23. 사원의 emplyee(사원)테이블에 있는 last_name, hire_date 및 근무 6개월 후 첫번째 월요일에 해당하는 급여 협상 날짜를 표시합니다. 열 레이블을 REVIEW 로 지정합니다. 날짜는 "월요일, the Second 4, 2007"과 유사한 형식으로 나타나도록 지정합니다.
SELECT
    last_name,
    hire_date,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), '월요일'), 'day", the" Ddthsp fmmm", " yyyy') REVIEW /* Dd(日(첫글자 대문자, 뒤는 소문자))th(서수 표현(1st, 2nd, 3rd, 4th. . .))sp(숫자를 영어 단어로 표시) == day 영어 수서 단어로 표시 */
FROM HR.EMPLOYEES;

--[문제24] 짝수달에 입사한 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE MOD(TO_CHAR(hire_date, 'mm'), 2) = 0
ORDER BY hire_date DESC;

--[문제25] 2006년도 홀수달에 입사한 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE TO_CHAR(hire_Date, 'yyyy') = '2006' AND MOD(TO_CHAR(hire_date, 'mm'), 2) = 1
ORDER BY hire_date DESC;

--26.
SELECT last_name, salary,
    CASE 
        WHEN salary BETWEEN 0 AND 4999 THEN 'low'
        WHEN salary < 10000 THEN 'medium'
        WHEN salary < 20000 THEN 'good'
        WHEN salary >= 20000 THEN 'excellent'
        ELSE 'salary ERR'
    END AS "사원들의 급여"
FROM HR.EMPLOYEES
ORDER BY salary DESC;
