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
