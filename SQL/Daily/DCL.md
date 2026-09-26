### DCL(Data Control Language)
- GRANT, REVOKE
- 시스템 권한 : DataBase 영향을 줄수 있는 권한 ( CREATE SESSION )
- 객체 권한 : 객체(테이블, 뷰, 시퀀스, 동의어, 프로시저, 함수, 패키지. . . 등) 사용할수 있는 권한
```SQL
SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'SYS';


SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'HR'; /* ' HR ' 유저에게 부여한 권한 정보 조회 */
```
```SQL
SELECT *
FROM USER_SYS_PRIVS;  /* 일반 유저 입장에서, 본인의 시스템 권한 조회 */


SELECT *
FROM USER_TAB_PRIVS /* 일반 유저 입장에서, 본인의 객체 권한 조회 */
```
</br></br></br>
#### GRANT
```SQL
GRANT CREATE SESSION TO insa; /* SQLPLUS 접속 가능한, 시스템 권한 부여 */


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
