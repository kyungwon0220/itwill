select last_name
from HR.EMPLOYEES
where last_name not between 'Ac' and 'Ax' /* 알파벳도 사전식 기준으로 문자열 비교하여 범위를 판단 */
order by last_name;


--OR == IN
select * from hr.employees where employee_id = 100 or employee_id = 150;
select * from hr.employees where employee_id in (100, 150);


select last_name from hr.employees where last_name is not null;


--ESCAPE
select * from hr.employees where last_name like 'HR^_^%%' escape'^';


select last_name, upper(last_name), lower(last_name), initcap(last_name)
from hr.employees;


select first_name, last_name, job_id, concat(concat(last_name || ' ', first_name) || ', ', job_id)
from hr.employees;


select length('oracle'), lengthb('oracle'), length('����Ŭ'), lengthb('����Ŭ') from dual;
