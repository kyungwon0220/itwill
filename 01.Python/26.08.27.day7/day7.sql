/*select LastName, FirstName, EmployeeId
from employees
where EmployeeId > 5 and EmployeeId <8
order by EmployeeId ASC;


select *
from albums
where title like 'w_%';
*/

/* 아래 ' ATTACH '코드는, 현재 환경상 안되는듯? DB 파일의 문제인지도 검증 필요 */
ATTACH DATABASE 'C:\Users\ITWILL\Desktop\sin\pyclass\26.08.27.day7\37.db' AS new;

select *
from new.student

DETACH DATABASE new;
