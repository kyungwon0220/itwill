SELECT LEVEL, employee_id, last_name, manager_id /* LEVEL == 트리 층을 나타내는 가상 테이블 */
FROM HR.EMPLOYEES
START WITH employee_id = 100 /* 시작점 ( root ) */
CONNECT BY PRIOR employee_id = manager_id; /* 연결 고리 조건 */


SELECT employee_id, last_name, manager_id
FROM HR.EMPLOYEES
START WITH employee_id = 101 /* 시작점 ( root ) */
CONNECT BY employee_id = PRIOR manager_id; /* 연결 고리 조건 */


SELECT LEVEL,
        LPAD(' ', LEVEL * 2, ' ') || last_name AS name,
        employee_id,
        manager_id,
        department_id,
        (SELECT department_name
            FROM hr.departments
            WHERE e.department_id = department_id) AS part,
        LTRIM(SYS_CONNECT_BY_PATH(last_name, '/'), '/') path
FROM HR.EMPLOYEES e
START WITH employee_id = 101 /* 시작점 ( root ) */
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name; /* SIBLINGS == 같은 LEVEL 안에서 */


SELECT LEVEL, employee_id, last_name, manager_id
FROM HR.EMPLOYEES 
START WITH employee_id = 111
CONNECT BY employee_id = PRIOR /* 최하위 노드 (시작점) */ manager_id;
