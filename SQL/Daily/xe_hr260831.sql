select * from hr.employees;

select * from user_tables;

select * from hr.employees where employee_id = 100;

select
    salary * 12 연봉,
    ' 사번 : ' || employee_id " 사 번 "
from hr.employees;

desc hr.employees;

select unique department_id, job_id
from hr.employees;
