### 
- No listener 상태에서,
---
</br></br></br>


### ORA-01078 LRM-00109
- [초기 파라미터 파일 ( Initalization Parameter File )](InitializationParameterFileAndParameter.md#initial-parameter-file) 없는 상태에서 ' startup ' 시도시 ERR
```SQL
startup
```
```cmd
ORA-01078: failure in processing system parameters
LRM-00109: could not open parameter file '/u01/app/oracle/product/19.3.0/dbhome_1/dbs/initora19c.ora'
```
---
</br></br></br>


### ORA-02095
- [Static Parameter](InitializationParameterFileAndParameter.md#static-parameter), ' ALTER ' 명령으로 수정 시도시 ERR
```SQL
ALTER SYSTEM SET processed=500;
--ALTER SYSTEM SET processes=500 SCOPE=SPFILE; /* ' SCOPE=SPFILE ' 사용하여, ' 초기 파라미터 파일 ' 통해서만, 수정 가능 */
```
```
ORA-02095: specified initialization parameter cannot be modified
```
---
</br></br></br>


### ORA-00372 ORA-01110 ORA-01647
- [Read Only Mode](261015.md#read-only-mode-tablespace) Tablespace 內 Segment DML 및 DDL 작업 수행 시도시 ERR
```SQL
DELETE FROM INSA.EMP WHERE department_id = 20;


CREATE TABLE INSA.dept
TABLESPACE insadata
AS SELECT * FROM HR.DEPARTMENTS;
```
```
ORA-00372: 파일 5는 지금 수정될 수 없습니다
ORA-01110: 5 데이터 파일 : '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf'


ORA-01647: 'INSADATA' 테이블스페이스는 읽기 전용입니다. 영역을 할당할 수 없습니다.
01647. 00000 - "tablespace '%s' is read-only, cannot allocate space in it"
*Cause: Tried to allocate space in a read-only tablespace
*Action: Create the object in another tablespace
```
---
