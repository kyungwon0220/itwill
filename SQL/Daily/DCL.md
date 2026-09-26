## 260910tue
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
FROM SYS.TAB$; /* Oracle 내부 DATA 딕셔너리 TABLE ( 내부 구현에 사용하는 테이블로서, 일반적인 SQL 개발에서는 직접 조회하기보다 공식 Data Dictionary View 사용 권장 ) */


SELECT *
FROM SYS.COL$; /* Oracle 내부 DATA 딕셔너리 TABLE ( 데이터베이스 객체의 컬럼(열) 관련 내부 정보를 저장 ) */
```
```SQL
SELECT *
FROM DBA_TABLES; /* 테이블 정보용 공식 Dictionary View ( DB 전체의 테이블을 확인할 수 있는 권한 필요 ) */


SELECT *
FROM DBA_USERS; /* DB 전체 사용자 정보 ( DBA 권한 또는 해당 데이터 딕셔너리 뷰를 조회할 수 있는 권한 필요 )*/


SELECT *
FROM DBA_ROLES; /* 현재 DB, 생성되어있는 ROLE 확인 */


SELECT *
FROM DBA_TEMP_FILES; /* 임시 테이블 스페이스 조회 */
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
```
> 일반 유저 세션에서의, 권한 조회 예제 코드 ( DBA 세션에서도 동일하게 조회 가능 )
---
</br></br></br>
### DCL(Data Control Language)
- GRANT, REVOKE
#### GRANT
```SQL
GRANT CREATE SESSION TO insa; /* SQLPLUS 접속 가능한, 시스템 권한 부여 */


GRANT CREATE TABLE TO insa; /* 테이블 생성이 가능하게, 시스템 권한 부여 */


GRANT SELECT ON HR.EMPLOYEES TO insa; /* 객체 권한 부여 */
```
- 객체 권한은 DBA, 객체 소유자가 권한 부여 가능
</br></br></br>
#### REVOKE
```SQL
REVOKE CREATE SESSION FROM insa; /* 시스템 권한 회수 ( 이미 접속중인 세션은, 그대로 동작 (재접속시, 접속 불가) ) */


REVOKE SELECT ON HR.EMPLOYEES FROM insa; /* 객체 권한 회수 */
```
- 객체 권한은 DBA, 객체 소유자가 권한 회수 가능
---
