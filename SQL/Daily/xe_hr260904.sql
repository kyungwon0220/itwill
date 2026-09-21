select department_id as "dept", sum(salary), count(*)
from hr.employees
group by department_id /* ' 1 ', ' dept ' 식으로, 열의 별칭이나 위치 표기법 사용 불가 */
order by 3 desc;


select job_id, sum(salary), count(*)
from hr.employees
group by job_id
order by 1 desc;


select department_id, job_id, sum(salary)
from hr.employees
group by department_id, job_id; /* SELECT 절 內 그룹 함수내에 들어있지 않은, 일반 개별 컬럼들 */


select department_id, to_char(hire_date, 'yyyy') year, count(*)
from hr.employees
group by department_id, to_char(hire_date, 'yyyy') /* SELECT 절 內 그룹 함수외의 개별 컬럼들을, 별칭 없이 GROUP BY 절에 필수 */
order by 3 desc;


select department_id, sum(salary)
from hr.employees
where last_name like '%i%'
group by department_id
having sum(salary) >= 10000 /* 그룹화한 결과에서의 제한 조건 */
order by 1 desc;


select department_id, sum(salary)
from hr.employees
group by department_id
having count(*) >= 5; /* SELECT 절에 없는, 조건으로도 제한 가능*/


select employee_id, last_name, department_name /* Cartesian Product (카티시안 곱) == 두 테이블의, 행 수가 서로 곱해진 결과 */
from hr.employees, hr.departments;

select hr.employees.employee_id, hr.employees.last_name, hr.departments.department_name
from hr.employees, hr.departments
where hr.employees.department_id = hr.departments.department_id;
