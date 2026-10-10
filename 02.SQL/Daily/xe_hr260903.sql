/* 숫자 모델 요소 참고 주소 : https://docs.oracle.com/en/database/oracle/oracle-database/18/sqlrf/Format-Models.html#GUID-22F2B830-261E-4BF0-91FB-6A1DAFC6D0A3:~:text=Table%202%2D15%20Number%20Format%20Elements */
select
    to_char(salary, 'l999g999d000') salary_1, /* g == 천단위 구분자, d == 소수점 구분자, l == 통화(\, $, 등), ( 현재 세션에 적용된 지역 및 포맷값에 따라서 출력 ) */
    to_char(salary, '000,999.99') salary_2 /* 0 == 빈자리를 0으로 표시 ( 소수점 이하 자리는, 9나 0 ' .99 ' OR ' .00 ' 표시해도 빈자리까지 0으로 출력 ) */
from hr.employees;
select
    to_char(-1111, '9999pr'), /* pr == x가 음수일 경우, ' <x> ' 출력*/
    to_char(-2222, '9999mi'), /* 숫자의 우측 끝에 ' mi ' 붙여주면, 음수인 경우엔 숫자끝에 ' - ' 부호 출력 */
    to_char(2222, '9999s') /* s 붙여주면, s위치에 부호 출력 */
from dual;


select
    nvl(to_char(commission_pct), 'no comm'), /* NVL(x, y) == x, y 데이터 타입이 일치해야 한다 */
    nvl2(commission_pct, salary, salary * 12), /* NVL2(x, y, z) == y, z 데이터 타입이 일치해야 한다 */
    coalesce(commission_pct, null, null, null), /* 인자 개수 제한이 없고, 모두 NULL 이라면 NULL 반환 */
    nullif(commission_pct, null)
from hr.employees;


select salary,
    decode(job_id,
        'AC_ACCOUNT', salary, /* job_id == AC_ACCOUNT 라면, salary 반환 */
        'AC_MGR', salary * 0, /* job_id == AC_MGR 라면, salary * 0 반환 */
        null) as DECODE /* job_id 비교값이 없을 경우, 마지막 인자인 ' NULL ' 반환 */
from HR.EMPLOYEES
order by job_id;


select salary,
    case job_id
        when 'AC_ACCOUNT' then salary
        when 'AC_MGR' then salary * 0
        else null
    end as CASE
from HR.EMPLOYEES
order by job_id;


select
    count(*),
    count(commission_pct), /*107 - NULL 72개 */
    count(department_id),
    count(unique department_id),
    count(distinct department_id),
    sum(commission_pct), /* NULL 제외한 나머지 행들의 합 */
    median(salary), /* 중앙 값 */
    avg(salary), /* 평균 값 */
    variance(salary), /* 숫자 데이터의 분산 */
    stddev(salary) /* 표준 편차 */
from hr.employees;
