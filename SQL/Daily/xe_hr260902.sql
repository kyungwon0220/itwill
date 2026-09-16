--OR == IN
select * from hr.employees where employee_id = 100 or employee_id = 150;
select * from hr.employees where employee_id in (100, 150);


select length('oracle'), lengthb('oracle'), length('오라클'), lengthb('오라클') from dual;


select substr('abcdef', 1, 3), substrb('abcdef', 1, 3), substr('가나다라', 1, 3), substrb('가나다라', 1, 3) from dual;


select trim('a' from 'aaoracleaassaa') from dual; /* 양쪽에 연속되는 ' a ' 제거 */
select trim(both 'a' from 'aaoracleaassaa') from dual; /* == trim() */

select ltrim('aaoracleaassaa', 'a') from dual; /* 왼쪽에 연속되는 'a' 제거 */
select trim(leading 'a' from 'aaoracleaassaa') from dual; /* == ltrim() */

select trim(trailing 'a' from 'aaoracleaassaa') from dual; /* == rtrim() */
select rtrim('aaoracleaassaa', 'a') from dual; /* 오른쪽에 연속되는 'a' 제거 */


select replace('100-001', '-', '%') from dual; /* 치환 */
select replace('-1-00-001-', '-', '') from dual; /* 특정 문자 제거 가능 */
select replace('     100     001     ', ' ', '') from dual; /* 공백 제거 가능 */


select round(55.926, -2), round(55.926, 2) from dual; /* 지정한 자릿수에서 반올림 */
select trunc(155.926, -2), trunc(155.926, 2) from dual; /* 지정한 자릿수에서 버림 */
select ceil(10.001) from dual; /* 올림 */
select 12/7, mod(12, 7) from dual; /* 나머지 값을 반환 */
select 2*2*2, power(2, 3) from dual; /* 제곱승 */
select abs(-15) "Absoute" from dual; /* 절대값 */
select sqrt(9) "Square root" from dual; /* 루트 적용값(제곱근 == Square root) */


select * from NLS_DATABASE_PARAMETERS; /* DB 자체에 설정된 NLS 관련 기본값 */
select * from NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT'; /* 현재 설정된 날자 타입 DATA 표기 방식 ( YYYY/MM/DD ) */

--지역 설정 요소 참고 주소 : https://docs.oracle.com/en/database/oracle/oracle-database/19/nlspg/appendix-A-locale-data.html#GUID-D2FCFD55-EDC3-473F-9832-AAB564457830
select * from v$timezone_names where tzname like 'Asia/S%'; /* Asia/S로 시작하는, 타임존 목록 조회 */
select SESSIONTIMEZONE FROM DUAL; /* 현재 세션의 타임존 출력 ( Asia/Seoul ) */

alter session set nls_territory = china; /* 현재 세션 지역 설정 변경 */
alter session set nls_language = 'simplified chinese; /* 현재 세션 언어 설정 변경 */

alter session set TIME_ZONE = '+09:00'; /* 현재 세션의 시간대를 UTC+08:00 변경 */
alter session set TIME_ZONE = 'Asia/Seoul'; /* 현재 세션의 시간대 지역을 Asia/Seoul 변경 */


--날짜 모델 요소 참고 레퍼런스 주소 : http://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Format-Models.html#GUID-EAB212CF-C525-4ED8-9D3F-C76D08EEBC7A
select
    sysdate, /* DB 서버의 현재 날짜, 시간 (시간 정보까지 갖고 있으나, 현재 세션의 ' NLS_DATE_FORMAT ' 타입에 맞추어 출력 ) */
    systimestamp, /* 현재 서버 날짜, 시간, 타임존 ( 26/09/02 13:59:37.535000000 +09:00 */
    
    current_date, /* 현재 세션의 ( 클라이언트 ) 날짜  */
    current_timestamp, /* 현재 세션의 (클라이언트) 날짜, 시간, 타임존 ( 26/09/02 13:59:37.000000000 ASIA/SEOUL ) */
    localtimestamp /* 현재 세션의 날짜 (클라이언트), 시간 ( 26/09/02 13:59:37.000000000 ) */
from dual;


select
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss.sssss') as "날짜_시간", /* 초 이하는, 5자리까지 추출 가능 */
    to_char(sysdate, 'yyyy"년" fmmm"월" dd"일"') "날짜",
    to_char(sysdate, 'yyyy yy rr rrrr year') as "년도",
    to_char(sysdate, 'month mon mm fmmm') as "달", /* fm == 선행되는 0을 제거하는 요소 */
    to_char(sysdate, 'ddd dd d ddth ddsp ddthsp') as "일",
    to_char(sysdate, 'day dy') as "요일",
    to_char(sysdate, 'q"분기"') as "분기",
    to_char(sysdate, 'ww iw w') "주", /* iw == ISO 국제 기준*/
    to_char(sysdate, 'hh hh12 hh24 am pm') "시간"
from dual;


select
  tz_offset('Asia/Seoul')M, /* 'Asia/Seoul' OFFSET 시간대 출력 (+09:00) */
  systimestamp + 9/24M, /* +9시간 */
  to_char(systimestamp + 10/(24*60), 'yyyy-mm-dd hh24:mi:ss.sssss'), /* +10분 */
  systimestamp, to_char(systimestamp + 10/(24*60*60), 'yyyy-mm-dd hh24:mi:ss'), /* +10초 */
  add_months(sysdate, 5), /* + 5달 */
  next_day(sysdate, 1), /* 입력한 날자 기준으로, 가장 먼저 나오는 요일 날짜 반환 */
  next_day(sysdate, '월요일'), /* 입력한 날자 기준으로, 가장 먼저 나오는 요일 날짜 반환 ( 현재 세션이 KOREAN 언어로 세팅되어 있기에, 한글 요일 지정 가능 ) */
  last_day(sysdate), /* 입력한 날자에 해당하는 달의, 마지막 일자 반환 */
  last_day(add_months(sysdate,1))
from dual;

select employee_id, ROUND(sysdate - hire_date, 2) AS "근무 일수" from HR.EMPLOYEES; /* NUMBER 타입 반환 */
