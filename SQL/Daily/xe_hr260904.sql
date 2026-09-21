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
where hr.employees.department_id = hr.departments.department_id; /* JOIN 조건 술어 */


select hr.employees.employee_id, hr.employees.last_name, hr.departments .department_name
from hr.employees e, hr.departments d /* ' e '. ' d ' 같이, 별칭을 선언하고 사용하지 않으면 ERR 발생 */
where e.department_id = d.department_id;


select last_name, city
from hr.employees e, hr.departments d, hr.locations l
where e.department_id = d.department_id and d.location_id = l.location_id
order by city;


select employee_id, last_name, department_name
from hr.employees e, hr.departments d
where e.department_id(+) = d.department_id; /* JOIN 조건 술어에서 ' (+) ' 안붙은, hr.departments 테이블 기준으로(모든 부서명 출력) RIGHT OUTER JOIN */


select employee_id, last_name, department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id(+); /* JOIN 조건 술어에서 ' (+) ' 안붙은, hr.employee 테이블 기준으로(모든 사원 출력) LEFT OUTER JOIN */


select e.employee_id, e.last_name, d.department_name, l.city
from hr.employees e, hr.departments d, hr.locations l
where e.department_id = d.department_id(+)
AND d.location_id = l.location_id(+);


select w.employee_id, w.last_name, m.employee_id, m.last_name
from hr.employees w, hr.employees m
where w.manage_id = m.employee_id; /* SELF JOIN */
