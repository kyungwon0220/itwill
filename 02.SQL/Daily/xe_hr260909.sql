SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.department_name /* ' HR.EMPLOYEES ' 테이블의 각 ROW에 대해서 ' HR.DEPARTMENTS ' 테이블에 JOIN하여 부서 정보를 가져오기에, ' HR.EMPLOYEES ' 테이블의 ROW 수만큼 I/O 발생 */
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.department_id = d.department_id(+)
ORDER BY 4 DESC;


SELECT e.employee_id, e.last_name, e.department_id, (SELECT department_name /* 동일한 department_id 입력값에 대한, Scalar 서브쿼리 결과는 재사용될 수 있기에 ' HR.DEPARTMENTS ' ROW 수만큼 I/O 발생 ( 캐시에 담아둔 값을 RETURN )*/
                                                        FROM HR.DEPARTMENTS
                                                        WHERE department_id = e.department_id ) department_name/* 각 ' HR.EMPLOYEES ' 테이블의 ROW에서, department_id를 이용해 ' HR.DEPARTMENTS ' 테이블의 department_name 하나를 반환 */
FROM HR.EMPLOYEES e
ORDER BY 3 DESC;


SELECT employee_id, job_id, salary
FROM HR.EMPLOYEES
UNION /* 중복을 제거한, 합집합 결과 */
SELECT employee_id, job_id, NULL
FROM HR.JOB_HISTORY
ORDER BY 3 DESC;


SELECT employee_id, job_id
FROM HR.EMPLOYEES
INTERSECT /* 교집합 개념 */
SELECT employee_id, job_id
FROM HR.JOB_HISTORY;


SELECT employee_id
FROM HR.EMPLOYEES
MINUS /* 차집합 */
SELECT employee_id
FROM HR.JOB_HISTORY;


SELECT department_id, job_id, manager_id, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY ROLLUP(department_id, job_id, manager_id);


SELECT department_id, job_id, manager_id, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY CUBE(department_id, job_id, manager_id);


SELECT department_id, job_id, manager_id, SUM(salary)
FROM HR.EMPLOYEES
GROUP BY GROUPING SETS((department_id, job_id), (department_id, manager_id), ()); /* ' () ' == 전체 집계값 1행 추가 */
