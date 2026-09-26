SELECT * FROM USER_SYS_PRIVS; /* 일반 유저 입장에서, 본인의 시스템 권한 조회 */
SELECT * FROM USER_TS_QUOTAS; /* 현재 접속한 사용자의(본인) TABLESPACE QUOTA 조회 */
SELECT * FROM USER_TAB_PRIVS; /* 일반 유저 입장에서, 본인의 객체 권한 조회 */
SELECT * FROM USER_OBJECTS; /* 일반 유저 입장에서, 본인이 생성한 객체 조회 */
SELECT * FROM USER_TABLES; /* 현재 접속한 사용자가(본인) 소유한 테이블 정보 */
SELECT * FROM USER_TAB_COLUMNS; /* 내가 소유한 테이블의 컬럼 */
SELECT * FROM USER_USERS; /* 현재 접속한 사용자(본인)의 정보 */


--■ 테이블생성
--테이블 생성 하려면, 두가지 체크
--1) 테이블을 생성할 수 있는 시스템 권한 ( CREATE TABLE 시스템권한 )
--2) 테이블스페이스를 사용할 수 있는 권한 ( QUOTA )
CREATE TABLE insa.EMP(id NUMBER, name VARCHAR2(30), day DATE DEFAULT SYSDATE)
TABLESPACE users; /* 실무에서는 TABLESPACE 필히 작성해 주는게 좋다 (생략시, 사용자의 DEFAULT TABLESPACE 위치에 생성)*/


--테이블 이름, 컬럼 이름, 유저 이름, 타객체명, 제약 조건 이름
--- 문자로 시작
--- 문자 길이 1 ~ 30
--- 문자, 숫자, 특수 문자 3가지(_, #, $) 가능
--- 대소문자 구분하지 않는다
--- 하나의 유저가, 동일명 객체 소유 불가 ( 다른 소유자끼리는 같은 객체명 소유 가능 )
--- 예약어 사용 불가
SELECT * FROM v$reserved_words WHERE reserved = 'Y'; /*  객체명/식별자로 사용이 제한되는 예약어 조회 */


DROP TABLE insa.emp PURGE;


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


UPDATE insa.EMP
SET day = DEFAULT /* TABLE 생성시에 지정한 디폴트 값으로 UPDATE 가능 */
WHERE id = 6;
COMMIT; /* 트랜잭션 종료 */


UPDATE insa.EMP
SET name = 'Jerry'; /* 모든 name 컬럼, ' Jerry ' 수정된다 ( Transaction 시작 )*/
ROLLBACK; /* 트랜잭션 종료 */


DELETE FROM insa.EMP
WHERE id = 1; /* DML 정상 수행으로, Transaction 시작 */


DELETE FROM insa.EMP; /* TABLE 전체 행을 삭제 */
ROLLBACK; /* Transaction 종료 (Transaction 시작절까지 포함하여, 취소) */


SELECT * FROM insa.EMP;
