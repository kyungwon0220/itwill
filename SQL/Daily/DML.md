## 260910tue
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
</br></br></br>


### TCL(Transaction Control Language)
- Transaction : 논리적으로, DML 하나로 묶어 처리하는 ' 작업 단위 '
- COMMIT
- ROLLBACK
- SAVEPOINT
