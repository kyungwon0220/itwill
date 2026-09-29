## 260910thu
### DML(Data Manipulation Language)
- DML 정상 성공시, Transaction 발생 ( TCL 사용하여, 확정 필요 )
#### INSERT
```SQL
INSERT INTO insa.emp(id, name, day)
VALUES( 1, '홍길동', TO_DATE('2026-09-10', 'yyyy-mm-dd')); /* DML 정상 수행으로, Transaction 시작 */

INSERT INTO insa.emp(id, name, day)
VALUES( 2, 'Emma', TO_DATE('20260810', 'yyyymmdd'));

INSERT INTO insa.emp(id, name) /* 삼번 인자를 입력하지 않았지만, TABLE 생성시에 day 컬럼 디폴트 값이 설정되어 있기에 정상 동작 */
VALUES( 3, 'Liam');

INSERT INTO insa.emp(id, name, day)
VALUES( 4, 'James', DEFAULT); /* ' DEFAULT ' 입력시, TABLE 생성시에 지정한 디폴트 값으로 자동 입력 */

INSERT INTO insa.emp(id, name, day)
VALUES( 5, DEFAULT, SYSDATE); /* TABLE 생성시에 지정한 디폴트 값이 없는 경우, NULL 자동 입력 */

INSERT INTO insa.emp(id, name, day)
VALUES( 6, 'Mraz', NULL); /* TABLE 생성시에 지정한 디폴트 값이 있어도, 직접 NULL 입력 가능 */


COMMIT; /* Transaction 종료 (Transaction 시작절까지 포함하여, 영구 저장) */
```
> TCL 사용하여, 확정지어주지 않는다면, 다른 세션에서는 INSERT 결과가 보이지 않는다 ( 읽기 일관성 )

|id|name|day|
---:|:---|:---|
1|홍길동|2026/09/10 00:00:00|
2|Emma|2026/08/10 00:00:00|
3|Liam|2026/09/27 02:46:53|
4|James|2026/09/27 02:51:44|
5|(null)|2026/09/27 02:51:52|
6|Mraz|(null)|
> ' COMMIT; ' 수행하여, 영구 저장된 결과

</br></br></br>


```SQL <a id="sql-correlated-subquery-insert"></a>
INSERT INTO CTAS_EMP SELECT * FROM HR.EMPLOYEES; /* INSERT SUBQUERY (  DML 정상 수행으로, Transaction 시작 ) */


INSERT INTO HR.MGR(ID, NAME, DAY)
SELECT employee_id, UPPER(last_name) name, TO_CHAR(hire_date, 'yyyy-mm-dd') day /* 표현식 존재시, 별칭 지정 필수 */
FROM HR.EMPLOYEES o
WHERE EXISTS ( SELECT NULL /* Correlated Subquery 이용한, INSERT */ /* MEMO ( 차후 디버깅 복습 필요 예정 ) */
                FROM HR.EMPLOYEES
                WHERE manager_id = o.EMPLOYEE_ID);


ROLLBACK; /* Transaction 종료 (Transaction 시작절까지 포함하여, 취소) */
```
</br></br></br>
```SQL
INSERT ALL /* Multi Table INSERT */
	INTO HR.SAL_HISTORY(id, day, sal)
    VALUES(no, hire, sal) /* 타겟 */


	INTO HR.MGR_HISTORY(id, mgr, sal)
    VALUES(no, mgr, sal) /* 타겟 */
SELECT employee_id no, manager_id mgr, hire_date hire, salary * 12 sal
FROM HR.EMPLOYEES; (  DML 정상 수행, Transaction 시작 )


INSERT ALL
WHEN day < TO_DATE('2005-01-01', 'yyyy-mm-dd') AND sal >= 5000 THEN /* 조건 Multi Table INSERT ( 조건을 만족하는 INTO 절에 모두 INSER )*/
    INTO HR.SAL_HISTORY(id, day, sal)
    VALUES(id, day, sal)
WHEN comm IS NOT NULL THEN
    INTO HR.MGR_HISTORY(id, comm, sal)
    VALUES(id, comm, sal)
SELECT employee_id ID, hire_date DAY, salary SAL, commission_pct comm
FROM HR.EMPLOYEES;


INSERT FIRST /* 조건 Multi Table INSERT ( 조건을 위에서부터 차례로 검사하며, 처음 만족하는 INTO 절 하나에만 INSERT ) */
WHEN salary < 5000 THEN
    INTO HR.SAL_LOW(id, name, sal)
    VALUES(employee_id, last_name, salary)
WHEN salary BETWEEN 5000 AND 10000 THEN
    INTO HR.SAL_MID(id, name, sal)
    VALUES(employee_id, last_name, salary)
ELSE
    INTO HR.SAL_HIGH(id, name, sal)
    VALUES(employee_id, last_name, salary)
SELECT employee_id, salary, last_name
FROM HR.EMPLOYEES;


ROLLBACK; /* Transaction 종료 (Transaction 시작절까지 포함하여, 취소) */
```

</br></br></br>
#### UPDATE
```SQL
UPDATE insa.EMP
SET day = NULL
WHERE id = 1; /* DML 정상 수행으로, Transaction 시작 */

UPDATE insa.EMP
SET day = DEFAULT /* TABLE 생성시에 지정한 디폴트 값으로 UPDATE 가능 */
WHERE id = 6;


COMMIT; /* Transaction 종료 (Transaction 시작절까지 포함하여, 영구 저장) */
```
> TCL 사용하여, 확정지어주지 않는다면, 다른 세션에서는 UPDATE 결과가 보이지 않는다 ( 읽기 일관성 )

|id|name|day|
---:|:---|:---|
1|홍길동|(null)
. . .|. . .|. . .|
6|Marz|2026/09/27 03:03:20|

> ' COMMIT; ' 수행하여, 영구 저장된 결과

</br></br></br>
```SQL
UPDATE insa.EMP
SET name = 'Jerry'; /* 모든 name 컬럼, ' Jerry ' 수정된다 ( Transaction 시작 )*/


ROLLBACK; /* Transaction 종료 (Transaction 시작절까지 포함하여, 취소) */
```
</br></br></br>


```SQL <a id="sql-correlated-subquery-update"></a>
UPDATE HR.EMP4 o
SET dept_id = (SELECT department_id
                FROM HR.EMPLOYEES
                WHERE employee_id = o.id); /* Correlated Subquery 이용한 UPDATE */ /* MEMO ( 차후 디버깅 복습 필요 예정 ) */
```
</br></br></br>
#### DELETE
```SQL
DELETE FROM insa.EMP
WHERE id = 1; /* DML 정상 수행으로, Transaction 시작 */


DELETE FROM insa.EMP; /* TABLE 전체 행을 삭제 */
ROLLBACK; /* Transaction 종료 (Transaction 시작절까지 포함하여, 취소) */
```
> TCL 사용하여, 확정지어주지 않는다면, 다른 세션에서는 DELETE 결과가 보이지 않는다 ( 읽기 일관성 )

</br></br></br>
#### MERTGE ( 병합. INSERT, UPDATE, DELETE 한번에 수행 가능 )
---
