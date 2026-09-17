## 260902wed
###
```SQL
SELECT * FROM NLS_DATABASE_PARAMETERS; /* DB 자체에 설정된 NLS 관련 기본 세팅값들 */
SELECT * FROM NLS_SESSION_PARAMETERS WHERE parameter = 'NLS_DATE_FORMAT'; /* 현재 설정된, 날자 타입 DATA 표기 방식 출력 ( YYYY/MM/DD ) */

SELECT * FROM v$timezone_names WHERE tzname LIKE 'Asia/S%'; /* Asia/S로 시작하는, 타임존 목록 조회 */
SELECT SESSIONTIMEZONE FROM DUAL; /* 현재 세션의 타임존 출력 ( Asia/Seoul ) */

ALTER SESSION SET nls_territory = china; /* 현재 세션 지역 설정 변경 */
ALTER SESSION SET nls_language = 'simplified chinese; /* 현재 세션 언어 설정 변경 */

ALTER SESSION SET TIME_ZONE = '+09:00'; /* 현재 세션의 시간대를 UTC+08:00 변경 */
ALTER SESSION SET TIME_ZONE = 'Asia/Seoul'; /* 현재 세션의 시간대 지역을 Asia/Seoul 변경 */
```
> 지역 설정 요소 참고 주소 : https://docs.oracle.com/en/database/oracle/oracle-database/19/nlspg/appendix-A-locale-data.html#GUID-D2FCFD55-EDC3-473F-9832-AAB564457830
---
</br></br></br>


###
```SQL
SELECT
    SYSDATE, /* DB 서버의 현재 날짜, 시간 (시간 정보까지 갖고 있으나, 현재 세션의 ' NLS_DATE_FORMAT ' 타입에 맞추어 출력 ) */
    SYSTIMESTAMP, /* 현재 서버 날짜, 시간, 타임존 (26/09/02 13:59:37.535000000 +09:00) */

    CURRENT_DATE, /* 현재 세션의 ( 클라이언트 ) 날짜 ( 2026/09/02 ) */
    CURRENT_TIMESTAMP, /* 현재 세션의 (클라이언트) 날짜, 시간, 타임존 ( 26/09/02 13:59:37.000000000 ASIA/SEOUL ) */
    LOCALTIMESTAMP /* 현재 세션의 날짜 (클라이언트), 시간 ( 26/09/02 13:59:37.000000000 ) */
FROM DUAL;
```
|SYSDATE|SYSTIMESTAMP|CURRENT_DATE|CURRENT_TIMESTAMP|LOCALTIMESTAMP|
|:---|:---|:---|:---|:---|
2026/09/16|26/09/16 19:50:53.154000000 +09:00|2026/09/16|26/09/16 19:50:53.000000000 ASIA/SEOUL|26/09/16 19:50:53.000000000|
---
</br></br></br>


### TO_CHAR(SYSDATE, *
```SQL
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'ds'),
    TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss.sssss') as "날짜_시간", /* 초 이하는, 5자리까지 추출 가능 */
    TO_CHAR(SYSDATE, 'yyyy"년" fmmm"월" dd"일"') "날짜",
    TO_CHAR(SYSDATE, 'dl'),
    TO_CHAR(SYSDATE, 'yyyy yy rr rrrr year') as "년도",
    TO_CHAR(SYSDATE, 'month mon mm fmmm') as "달", /* fm == 선행되는 0을 제거하는 요소 */
    TO_CHAR(SYSDATE, 'ddd dd d ddth ddsp ddthsp Ddthsp') as "일", /* Ddthsp == 첫자를 대문자, 나머지 소문자로 출력,  DDTHSP == 모두 대문자로 출력 */
    TO_CHAR(SYSDATE, 'day dy') as "요일",
    TO_CHAR(SYSDATE, 'q"분기"') as "분기",
    TO_CHAR(SYSDATE, 'ww iw w') "주", /* iw == ISO 국제 기준*/
    TO_CHAR(SYSDATE, 'hh hh12 hh24 am pm') "시간"
FROM DUAL;
```
> 날짜 모델 요소 참고 레퍼런스 주소 : http://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Format-Models.html#GUID-EAB212CF-C525-4ED8-9D3F-C76D08EEBC7A

|SYSDATE|'yyyy-mm-dd hh24:mi:ss.sssss' AS '날짜_시간'|'yyyy"년" fmmm"월" dd"일"' AS '날짜'|'yyyy yy rr rrrr year' AS '년도'|'month mon mm fmmm' AS '달'|'ddd dd d ddth ddsp ddthsp' AS '일'|'day dy' AS '요일'|'q"분기"'|'ww iw w' AS '주'|'hh hh12 hh24 am pm' AS '시간'|
:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
26/09/16|2026-09-16 19:17:08.69428|2026년 9월 16일|2026 26 26 2026 twenty twenty-six|9월  9월  09 9|259 16 4 16th sixteen sixteenth|수요일 수|3분기|37 38 3|07 07 19 오후 오후|
---
</br></br></br>


###
```SQL
SELECT
  TZ_OFFSET('Asia/Seoul'), /* 'Asia/Seoul' OFFSET 시간대 출력 (+09:00) */
  TO_DATE('26/06/22', 'yy-mm-dd'),
  SYSTIMESTAMP + 9/24, /* +9시간 날짜 ( 2026/09/17 ) */
  TO_CHAR(SYSTIMESTAMP + 10/(24*60), 'yyyy-mm-dd hh24:mi:ss.sssss'), /* +10분 ( 2026-09-16 20:16:58.73018 )*/
  TO_CHAR(SYSTIMESTAMP + 10/(24*60*60), 'yyyy-mm-dd hh24:mi:ss'), /* +10초 ( 2026-09-16 20:07:08 )*/
  ADD_MONTHS(SYSDATE, 5), /* + 5달 ( 2027/02/16 )*/
  NEXT_DAY(SYSDATE, 1), /* 입력한 날자 기준으로, 가장 먼저 나오는 요일 날짜 반환 ( 2026/09/20 ) */
  NEXT_DAY(SYSDATE, '월요일'), /* 입력한 날자 기준으로, 가장 먼저 나오는 요일 날짜 반환 ( 현재 세션이 KOREAN 언어로 세팅되어 있기에, 한글 요일 지정 가능 ) ( 2026/09/21 )*/
  LAST_DAY(SYSDATE), /* 입력한 날자에 해당하는 달의, 마지막 일자 반환 ( 2026/09/30 ) */
  LAST_DAY(add_months(SYSDATE,1)) /* ( 2026/10/31 ) */
FROM DUAL;
```
---
</br></br></br>


```SQL
SELECT employee_id, ROUND(sysdate - hire_date, 2) AS "근무 일수"
FROM HR.EMPLOYEES; /* NUMBER 타입 반환 */
```

|employee_id|근무 일수|
|---:|---:|
100|8492.85|
101|7665.85|
. . .|. . .|
---
</br></br></br>


```SQL
SELECT hire_date
FROM hr.employees
WHERE hire_date BETWEEN TO_DATE('2006-01-01', 'yyyy-mm-dd') AND TO_DATE('2006-12-31', 'yyyy-mm-dd')
ORDER BY 1;
```
- BETWEEN TO_DATE() 사용시 주의 사항
- 실행 계획을 보면, '2006-01-01 00:00:00' ~ '2006-12.31 00:00:00' 까지 추출
- 06.12.31 일자의 00시 이후 데이터는 누락
- 아래 코드처럼, 시간대까지 명시 가능
```SQL
SELECT hire_date
FROM hr.employees
WHERE hire_date BETWEEN TO_DATE('2006-01-01', 'yyyy-mm-dd') AND TO_DATE('2006-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss')
ORDER BY 1;
```
---
</br></br></br>


### DATE TYPE (yy-mm-dd), (rr-mm-dd) 
현재 년도|입력하고자는 년도 (**00 ~ **49)|입력하고자는 년도 (**50 ~ **99)|
|---|---|---|
**00년 ~ **49년|현재 세기|이전 세기|
**50년 ~ **99년|이후 세기|현재 세기|

입력 당시, 현재 년도|입력하고자는 날짜|YY|RR|
|---|---|---|---|
1994|95-10-27|1995-10-27|1995-10-27|
1994|17-10-27|1917-10-27|2017-10-27|
2001|17-10-27|2017-10-27|2017-10-27|
2048|52-10-27|2052-10-27|1952-10-27|
2051|47-10-27|2047-10-27|2147-10-27|

> RR DATE 타입 참고 주소 : https://docs.oracle.com/en/database/oracle/oracle-database/18/sqlrf/Format-Models.html#GUID-22F2B830-261E-4BF0-91FB-6A1DAFC6D0A3:~:text=Support%20Guide.-,The%20RR%20Datetime%20Format%20Element,-The%20RR%20datetime
---
</br></br></br>


```SQL
--[문제18] 20년 이상 근무한 사원들의 사원번호(employee_id), 입사날짜(hire_date),  근무개월수를 조회하세요.
SELECT employee_id, hire_date,
    TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) 근무개월수 /* 개월 수 차이값 반환 */
FROM HR.EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, hire_date)/12 >= 20
ORDER BY 3  DESC;
```
```SQL
--[문제19] 사원의 last_name,hire_date 및 근무 6 개월 후 월요일에 해당하는 날짜를 조회하세요. 열별칭은 REVIEW 로 지정합니다.
SELECT last_name, hire_date,
    NEXT_DAY(ADD_MONTHS(hire_date,6), '월요일') AS "REVIEW" /* 한가지 문제가 있다면, 6개월 후가 정확히 월요일인 경우에는 7일 후인 다음 월요일을 반환(출력) */
FROM HR.EMPLOYEES;
```
```SQL
--[문제20] 사원들의 사원번호, 입사한 요일을 출력하세요. 단 요일을 오름차순 정렬해주세요.
SELECT employee_id, hire_date, to_char(hire_date, 'day') "요일"
FROM HR.EMPLOYEES
ORDER BY to_char(hire_date-1, 'd'); /* SELECT 절에서 사용한 "요일" 과는 별개로서, 오직 원하는 요일 정렬을 위해서 hire_date -1 */
```
```SQL
--[문제21] employees테이블에서  일요일에 입사한 사원의 정보를 조회하세요.
SELECT *
FROM HR.EMPLOYEES
--WHERE to_char(hire_date, 'day') = '일요일'
WHERE TO_CHAR(hire_date, 'dy') = '일';
```
---
