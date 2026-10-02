## 260910thu
### 권한, ROLE
- 시스템 권한 : DataBase 영향을 줄수 있는 권한 ( CREATE SESSION )
- 객체 권한 : 객체(테이블, 뷰, 시퀀스, 동의어, 프로시저, 함수, 패키지. . . 등) 사용할수 있는 권한
- ROLE : 유저에게 부여할 권한 및 다른 ROLE 등을 묶어서 모아놓은 객체 ( 사용자에게 부여 )
- ' SYS.TAB$ ' 같이 $로 끝나는 객체는, 내부 구현에 사용하는 테이블로서 일반적인 SQL 개발에서는 직접 조회하기보단 공식 Data Dictionary View 사용 권장
```SQL
SELECT *
FROM DBA_DATA_FILES; /* Oracle 내부 데이터 딕셔너리 테이블 (TABLESPACE 자체를 조회하는 것이라기보다는, TABLESPACE가 사용하는 물리적인 DATAFILE을 조회) */ /* DB 데이터 파일 조회 ( 어떤 TABLESPACE가, 어떤 DATAFILE을 사용하는지 확인 ) */


SELECT *
FROM DBA_TS_QUOTAS; /* DB 전체 사용자의, TABLESPACE QUOTA 조회 */
```
- ' SELECT * FROM DBA_DATA_FILES; ' == 영구 TABLESPACE의 데이터 파일(Datafile) 정보 조회 ( 파일 경로, 크기, 자동 확장 여부, 어느 TABLESPACE에 속하는지 등 )
  - ' SELECT * FROM DBA_DATA_FILES; ' 결과중, ' TABLESPACE_NAME ' == 'SYSTEM', 'SYSAUX', 'UNDOTBS1' 항목은, 일반 유저가 사용 금지
- ' SELECT * FROM DBA_TS_QUOTAS; ' 결과중, ' MAX_BYTES ' == ' -1 ' 의미는 무한 ( -1 == 용량 제한 없다는 의미 )
---
</br></br></br>
```SQL
SELECT *
FROM SYS.OBJ$ /* 실제 DATA 저장된 테이블로서, 일반 유저는 조회 불가 ( 테이블, 인덱스, 뷰, 프로시저 등 모든 객체의 기본 메타 정보가 마스터격 )*/
WHERE name = 'EMPLOYEES';


SELECT *
FROM SYS.TAB$ /* 테이블의 실제 정보가 저장된 TABLE ( 테이블(Table)로서의 고유 특성(저장 공간 설정 등) )*/
WHERE OBJ# = 92696; /* 실제 테이블의 DATA 중, 'EMPLOYEES' 테이블의 ' OBJ# ' 값 */


SELECT *
FROM SYS.COL$ /* 테이블에 속한 컬럼(Column)들의, 메타 정보(데이터 타입, 길이 등)가 저장된 원본 딕셔너리 TABLE */
WHERE OBJ# = 92696; /* 실제 테이블의 DATA 중, 'EMPLOYEES' 테이블의 ' OBJ# ' 값 */


SELECT *
FROM SYS.CON$ /* 제약 조건(Constraints)의 고유 이름과 시스템 ID가 매핑된 원본 TABLE ( DBA_CONSTRAINTS 뷰와, USER_CONSTRAINTS 뷰의 원본 TABLE ) */
```
> CREATE TABLE 정상 수행시, 내부적으로 실제 데이터를 INSERT 작업 ( 내부적으로 AUTO COMMIT 발생 )

</br></br></br>
```SQL
SELECT *
FROM DBA_TABLES; /* 테이블 정보용 공식 Dictionary View ( DB 전체의 테이블을 확인할 수 있는 권한 필요 ) */


SELECT *
FROM DBA_USERS; /* DB 전체 사용자 정보 ( DBA 권한 또는 해당 데이터 딕셔너리 뷰를 조회할 수 있는 권한 필요 )*/


SELECT *
FROM DBA_ROLES; /* 현재 DB, 생성되어있는 ROLE 확인 */


SELECT *
FROM DBA_TEMP_FILES; /* 임시 테이블 스페이스 조회 */


SELECT *
FROM DBA_CONSTRAINTS; /* DB 전체 시스템의, 모든 제약 조건 조회 ( CON$ 테이블 기반 VIEW ) */


SELECT *
FROM DBA_CONS_COLUMNS; /* 컬럼별 제약 조건 조회 */


SELECT *
FROM DBA_INDEXES; /* 현재 사용자가 소유한 인덱스 정보 조회 */


SELECT *
FROM DBA_IND_COLUMNS; /* 인덱스를 구성하는 컬럼 정보 조회 */


SELECT *
FROM DBA_OBJECTS
WHERE OBJECT_NAME = 'EMPLOYEES'; /* ' SYS.OBJ$ ' 테이블에 대해 GUI 고려한 VIEW */


SELECT *
FROM DBA_TAB_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEES'; /* DB 內 모든 테이블의 컬럼 정보(데이터 타입, 길이, NULL 여부 등) ( COL$ 테이블 기반 VIEW ) */
```
```SQL
SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'HR'; /* ' HR ' 유저에게 ROLE 통하지 않고, 직접 부여한 시스템 권한 정보 조회 */


SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'CONNECT'; /* ' CONNECT ' 이름을 가진 ROLE 內 들어있는 권한들 조회 */


SELECT *
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'ORA1'; /* ' ORA1 ' 유저에게 부여한 ROLE 조회 */


SELECT *
FROM DBA_TAB_PRIVS
WHERE GRANTEE = 'INSA'; /* ' INSA ' 유저에게 부여된, ' 객체 권한 ' 조회 */
```
> DBA 세션에서의, 권한 조회 예제 코드 ( 일반 유저는 사용하여 조회 불가 )

</br></br></br>
```SQL
SELECT *
FROM USER_USERS; /* 현재 접속한 사용자(본인) 정보 조회 */


SELECT *
FROM USER_OBJECTS; /* 현재 접속한 사용자가(본인) 소유한 객체 조회 */


SELECT *
FROM ALL_OBJECTS; /* 현재 접속한 사용자가 조회 권한을 가진 모든 객체 조회 */


SELECT *
FROM USER_VIEWS; /* 현재 접속한 사용자가(본인) 소유한 가상 테이블(VIEW) 조회 */


SELECT *
FROM ALL_VIEWS; /* 현재 접속한 사용자가(본인) 조회 권한을 가진, 모든 가상 테이블(View) 조회 */


SELECT *
FROM USER_TABLES; /* 현재 접속한 사용자가(본인) 소유한 테이블 정보 */


SELECT *
FROM USER_TAB_COLUMNS; /* 현재 접속한 사용자가(본인) 소유한 테이블의 컬럼 */


SELECT *
FROM USER_SYS_PRIVS;  /* 현재 접속한 사용자의(본인) 시스템 권한 조회 */


SELECT *
FROM SESSION_ROLES; /* 현재 세션에서 활성화된 ROLE 조회 */


SELECT *
FROM ROLE_SYS_PRIVS; /* 현재 접속한 사용자가(본인), 현재 세션에서 활성화된 ROLE 통하여 사용 가능한 시스템 권한 조회 */


SELECT *
FROM SESSION_PRIVS; /* 현재 세션에서 사용할 수 있는 시스템 권한 조회 (ROLE 통해서 받거나, 직접 부여받은 시스템 권한 포함 ( USER_SYS_PRIVS UNION ROLE_SYS_PRIVS )) */


SELECT *
FROM USER_TAB_PRIVS; /* 현재 접속한 사용자가(본인) 소유한 객체에 대해, 부여된 ' 객체 권한 ' 조회 */


SELECT *
FROM USER_TS_QUOTAS; /* 현재 접속한 사용자의(본인) TABLESPACE QUOTA 조회 */


SELECT *
FROM USER_CONSTRAINTS; /* 내가 생성하고, 소유한 테이블의 제약 조건 (PK, FK 등) */


SELECT *
FROM USER_UNUSED_COL_TABS; /* ' SET UNUSED ' 처리한 컬럼의 개수 조회 */


SELECT *
FROM USER_CONS_COLUMNS; /* 컬럼별 제약 조건 조회 */


SELECT *
FROM USER_INDEXES; /* 현재 사용자가 소유한 인덱스 정보 조회 */


SELECT *
FROM USER_IND_COLUMNS; /* 인덱스를 구성하는 컬럼 정보 조회 */
```
> 일반 유저 세션에서의, 권한 조회 예제 코드 ( DBA 세션에서도 동일하게 조회 가능 )
---
</br></br></br>
### DCL(Data Control Language)
- GRANT, REVOKE
- DDL, DCL 문은 정상 수행되면 Auto COMMIT 발생
  - SQLPLUS 환경에서 EXIT 종료시 Auto COMMIT 발생 ( 자동으로 COMMIT 후에 종료 )
  - SQLPLUS 환경상 트랜잭션 상황에서, CONN 다른 계정으로 접속시 Auto COMMIT 발생
  - SQLPLUS 환경상, 강제 종료시 자동 ROLLBACK 발생 ( 자동으로 ROLLBACK 후에 종료 )
  - [260911.md TCL(Transaction Control Language)](260911.md#sql-tcl)
#### GRANT
```SQL
GRANT CREATE SESSION TO insa; /* SQLPLUS 접속 가능한, 시스템 권한 부여 */


GRANT CREATE TABLE TO insa; /* ' insa ' 유저 자신의 스키마에, TABLE 생성이 가능한 ' 시스템 권한 ' 부여 ( ' HR.EMP ' 같이, 다른 사용자의 스키마에 생성은 불가 ) */


GRANT SELECT ON HR.EMPLOYEES TO insa; /* ' insa ' 유저 자신의 스키마에, TABLE 조회가 가능한 ' 객체 권한 ' 부여 ( ' HR.EMPLOYEES ' 같이, 다른 사용자의 테이블 SELECT == 그에대한 별도의 권한 필요 )*/
```
- 객체 권한은 DBA, 객체 소유자가 권한 부여 가능
</br></br></br>
```SQL
GRANT CREATE ANY TABLE TO ORA1; /* DB 內 모든 사용자의 스키마에 테이블을 생성할 수 있는 시스템 권한(System Privilege) 부여 */


GRANT SELECT ANY TABLE TO ORA1; /* DB 內 모든 사용자의 테이블을 조회(SELECT)할 수 있는 시스템 권한(System Privilege) 부여 */


GRANT DROP ANY TABLE TO ORA1; /* DB 內 모든 사용자의 테이블을 삭제(DROP)할 수 있는 시스템 권한(System Privilege) 부여 */


GRANT INSERT ANY TABLE TO ORA1; /* DB 內 모든 사용자의 테이블에 데이터를 삽입(INSERT)할 수 있는 시스템 권한(System Privilege) 부여 */


GRANT UPDATE ANY TABLE TO ORA1; /* DB 內 모든 사용자의 테이블 데이터를 수정(UPDATE)할 수 있는 시스템 권한 부여 */


GRANT DELETE ANY TABLE TO ORA1; /* DB 內 모든 사용자의 테이블 데이터를 삭제(DELETE)할 수 있는 시스템 권한 부여 */
```
- 끝에, ' WITH ADMIN OPTION ' 붙일시, 부여받는 유저가 다른 유저에게 동일하게 시스템 권한 부여가 가능
  - 권한 부여자가, 권한 회수해도 연쇄적으로 회수되지 않는다
    - 예를들어, A 유저 입장에서 ' GRANT SELECT ANY TABLE TO B WITH ADMIN OPTION; ' == A 유저가 B 유저에게 시스템 권한과, 이를 부여할 권한까지 부여 ( B 유저가, 다른 유저에게 ' ADMIN OPTION ' 권한까지 부여 가능 )
    - B 유저가 C 유저에게 ' GRANT SELECT ANY TABLE TO C; ' == B 유저가 C 유저에게, ' 시스템 권한 ' 부여
    - A 유저가 B 유저의 권한을 회수해도
    - B 유저가 C 유저에게 부여한 시스템 권한까지 회수되지 않는다 ( C 유저 권한은 유지 )
- 끝에, ' GRANT OPTION ' 붙일시, 부여받는 유저가 다른 유저에게 동일하게 ' 객체 권한 ' 부여가 가능하나, ' GRANT OPTION ' 권한 부여는 불가
  - 반면, ' GRANT OPTION ' == 연쇄적인 권한 회수(CASCADE) 발생
    - 예를들어, A 유저 입장에서 ' GRANT SELECT ON HR.EMPLOYEES TO B WITH GRANT OPTION; ' == A 유저가 B 유저에게 객체 권한과, 이를 부여할 권한까지 부여 ( 단, ' GRANT OPTION ' 권한까지는 불가, ' 객체 권한 ' 부여만 가능 )
    - B 유저가 C 유저에게 ' GRANT SELECT ON HR.EMPLOYEES TO C; ' == B 유저가 C 유저에게, ' 객체 권한 ' 부여
    - A 유저가 B 유저의 권한을 회수하면
    - B 유저가 C 유저에게 부여한 권한까지 회수 ( 연쇄적인 권한 회수(CASCADE) 발생 )
</br></br></br>
#### REVOKE
```SQL
REVOKE CREATE SESSION
FROM insa; /* 시스템 권한 회수 ( 이미 접속중인 세션은, 그대로 동작 (재접속시, 접속 불가) ) */


REVOKE SELECT, INSERT, UPDATE, DELETE /* 객체 권한 회수 */
ON HR.EMPLOYEES
FROM insa;


REVOKE ALL /* 부여된 모든 객체 권한 회수 */
ON HR.EMPLOYEES
FROM insa;
```
- 객체 권한은 DBA, 객체 소유자가 권한 회수 가능
---
