SELECT level, LPAD(' ', level*2-2,' ') || last_name AS name, employee_id, manager_id, department_id, (select department_name from hr.departments where e.department_id = department_id) AS part,
        ltrim(sys_connect_by_path(last_name, '/'), '/') path
FROM HR.EMPLOYEES e
START WITH employee_id = 101 /* 최상위 노드 (시작점) */
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name; /* SIBLINGS = 형제 계층 안에서 */

SELECT LEVEL, employee_id, last_name, manager_id
FROM HR.EMPLOYEES 
START WITH employee_id = 111
CONNECT BY employee_id = PRIOR /* 최하위 노드 (시작점) */ manager_id;

--테이블 생성ㅅ ㅣCREATE TABL 권한, QUOTA (테이블 스페이스에 사용 가능 여부 권한) 필수

