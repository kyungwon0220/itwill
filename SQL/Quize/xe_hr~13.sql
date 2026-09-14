--[문제4] employees 테이블에서 급여가 2500 ~ 3500 인 사원들의 last_name, salary를 출력해주세요.
SELECT last_name, salary
FROM HR.EMPLOYEES
WHERE salary >= 2500 AND salary <= 3500
ORDER BY salary DESC;

SELECT last_name, salary
FROM HR.EMPLOYEES
WHERE salary BETWEEN 2500 AND 3500
ORDER BY salary DESC;

--[문제5] employees 테이블에서 급여가 2500 ~ 3500 아닌 사원들의 last_name, salary를 출력해주세요.
SELECT last_name, salary
FROM HR.EMPLOYEES
WHERE NOT(salary >= 2500 AND salary <= 3500)
ORDER BY salary DESC;

SELECT last_name, salary
FROM HR.EMPLOYEES
WHERE salary NOT BETWEEN 2500 AND 3500
ORDER BY salary DESC;

SELECT last_name, salary
FROM HR.EMPLOYEES
WHERE salary < 2500 OR salary > 3500
ORDER BY salary DESC;

--[문제6] employees 테이블에서 hire_date(입사일) 2001(01) ~ 2002(02)년도에 입사한 사원 정보를 출력해주세요.
SELECT * FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT'; /* 현재 설정된 날자 타입 DATA 표기 방식 */

SELECT last_name, hire_date AS "입사일"
FROM HR.EMPLOYEES
WHERE hire_date BETWEEN DATE '2001-01-01' AND '2002-12-31'
ORDER BY hire_date DESC;

--[문제7] employees 테이블에 있는 데이터 중에 job_id가 SA로 시작되고 salary 값은 10000이상 받는 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE job_id LIKE 'SA%' AND salary >= 10000
ORDER BY job_id DESC;

--[문제8] last_name의 세번째 문자가 'a' 또는 'e' 글자가 포함된 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE last_name LIKE '__a%' OR last_name LIKE '__e%'
ORDER BY last_name;

--[문제9] employees 테이블에 있는 데이터 중에 job_id가 SA로 시작되고 salary 값은 10000이상 받고 2005년도에 입사한(hire_date)사원들의 정보를 출력해주세요.
SELECT * FROM NLS_SESSION_PARAMETERS
WHERE parameter = 'NLS_DATE_FORMAT'; /* 현재 설정된 날자 타입 DATA 표기 방식 */

SELECT *
FROM HR.EMPLOYEES
WHERE job_id LIKE 'SA%' AND salary >= 10000 AND hire_date LIKE '05/%' /* 'LIKE % ', NLS 설정에 따라 ERR 발생 가능성 */
ORDER BY hire_date;

SELECT *
FROM HR.EMPLOYEES
WHERE job_id LIKE 'SA%' AND salary >= 10000 AND hire_date BETWEEN DATE '2005-01-01' AND '2005-12-31'; /* 같은 날자 타입끼리 비교로서, 추천 방식 */

SELECT *
FROM HR.EMPLOYEES
WHERE job_id LIKE 'SA%' AND salary >= 10000 AND hire_date BETWEEN '2005/01/01' AND '2005/12/31'; /* '2005/12/31' 방식 == 문자열 */

--[문제10] employees테이블에서 job_id 가 SA_REP 또는 AD_PRES 사원들 중에 salary값이 10000 초과한 사원들의 정보를 출력해주세요.
SELECT *
FROM HR.EMPLOYEES
WHERE (job_id = 'SA_REP' OR job_id = 'AD_PRES') AND salary > 10000;

SELECT *
FROM HR.EMPLOYEES
WHERE job_id IN('SA_REP', 'AD_PRES') AND salary > 10000;

--[문제11] 2006년도 입사한 사원의 employee_id, last_name, hire_date를 출력해주세요 단 last_name 이름을 기준으로 오름차순정렬 해주세요.
SELECT employee_id, last_name, hire_date
FROM HR.EMPLOYEES
WHERE hire_date BETWEEN DATE '2006-01-01' and '2006-12-31'
ORDER BY 2;

--[문제12] 80번 department_id 사원중에 commission_pct 값이 0.2 이고 job_id는 SA_MAN인 사원의 employee_id, last_name, salary를 출력해주세요.
--단 last_name 이름을 기준으로 오름차순정렬해 주세요.
SELECT employee_id, last_name, salary
FROM HR.EMPLOYEES
WHERE department_id = 80 AND commission_pct = 0.2 AND job_id = 'SA_MAN'
ORDER BY 2;

--[문제13] salary가 5000 ~ 12000의 범위에 속하지 않는 모든 사원의 last_name 및 salary를 출력해주세요. 단 salary을 기준으로 내림차순 정렬하세요.
SELECT last_name, salary
FROM HR.EMPLOYEES
WHERE salary NOT BETWEEN 5000 AND 12000
ORDER BY 2 DESC;
