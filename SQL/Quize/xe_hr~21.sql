--[문제14] employees 테이블에 last_name 컬럼의 값 중에 ?"J" 또는 "A" 또는 "M"으로 시작하는 사원들의 last_name, last_name의 길이를 표시하는 query(select문) 를 작성합니다.사원들의 last_name 기준으로 내림차순 정렬해 주세요.
SELECT last_name, LENGTH(last_name)
FROM HR.EMPLOYEES
--WHERE last_name LIKE 'J%' OR last_name LIKE 'M%' OR last_name LIKE 'A%'
--WHERE SUBSTR(last_name, 1, 1) = 'J' or SUBSTR(last_name, 1, 1) = 'A' OR SUBSTR(last_name, 1, 1) = 'M' /* == ' WHERE SUBSTR(last_name, 1, 1) IN('J', 'A', 'M') ' */
WHERE INSTR(last_name, 'J', 1, 1) = 1 OR INSTR(last_name, 'A', 1, 1) = 1 OR INSTR(last_name, 'M', 1, 1) = 1 /* INSTR 함수에서는, ' _ ', ' % ' 와일드 카드 사용 불가 */
ORDER BY last_name DESC;

--[문제15] employees테이블에서 department_id(부서코드)가 50번 사원들 중에 last_name에 두번째 위치에 "a"글자가 있는 사원들을 조회하세요.
SELECT last_name
FROM HR.EMPLOYEES
--WHERE department_id = 50 AND SUBSTR(last_name, 2, 1) = 'a';
--WHERE department_id = 50 AND last_name LIKE '_a%';
WHERE department_id = 50 AND INSTR(last_name, 'a', 2, 1) = 2;

--[문제16] salary에 있는 값을 1000당*출력해주세요.
--SALARY STAR
------- -----
--5000 *****
--2000 **
SELECT salary, lpad( ' ', salary/1000, '*' ) /* ' ' 공백 문자를 안넣으면, NULL 출력 */
FROM hr.employees
ORDER BY salary DESC;

--[문제17] employees 테이블에 있는 employee_id, last_name, salary, salary를 10% 인상된 급여를 계산하면서 계산된 급여는 소수점은 반올림해서 정수값으로 표현하고 열별칭은 New Salary로 표시하세요.
SELECT employee_id, last_name, salary, ROUND(salary * 1.1) AS "New salary"
FROM HR.EMPLOYEES;

--[문제18] 20년 이상 근무한 사원들의 사원번호(employee_id), 입사날짜(hire_date),  근무개월수를 조회하세요.
SELECT employee_id, hire_date, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) 근무개월수
FROM HR.EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, hire_date)/12 >= 20
ORDER BY 3  DESC;

--[문제19] 사원의 last_name,hire_date 및 근무 6 개월 후 월요일에 해당하는 날짜를 조회하세요. 열별칭은 REVIEW 로 지정합니다.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6), '월요일') AS "REVIEW" /* 한가지 문제가 있다면, 6개월 후가 정확히 월요일인 경우에는 7일 후인 다음 월요일을 반환 */
FROM HR.EMPLOYEES;

--[문제20] 사원들의 사원번호, 입사한 요일을 출력하세요. 단 요일을 오름차순 정렬해주세요.
SELECT employee_id, hire_date, to_char(hire_date, 'day') "요일"
FROM HR.EMPLOYEES
ORDER BY to_char(hire_date-1, 'd'); /* SELECT 절에서 사용한 "요일" 과는 별개로서, 오직 원하는 요일 정렬을 위해서 hire_date -1*/

--[문제21] employees테이블에서  일요일에 입사한 사원의 정보를 조회하세요.
SELECT *
FROM HR.EMPLOYEES
--WHERE to_char(hire_date, 'day') = '일요일'
WHERE to_char(hire_date, 'dy') = '일';
