### 초기 파라미터 파일 ( Initialization Parameter File ) <a id="initial-parameter-file"></a>
- ' select * from v$parameter ' 실행하여 확인이 가능한 파리미터들 中 DB 사용처의 상황에 맞추어, 세팅이 필요한 부분만
- 초기 파라미터 파일의, 고정 물리 위치 == $ORACLE_BASE/dbs
- 우선 순위는 Server Parameter File ( spfile ) > Text Parameter File ( pfile ) > 둘다 없을시, ERR
- 파라미터 수정시, 다음 DB 시작시 적용 ( DB 시작시 1회만 열어보기에 )
- 내용상 [Control 파일](#control-file) 물리적 위치 정보 소유
- ```SQL
  show parameter spfile
  ```
  > DB 시작시에 사용한, 초기 파라미터 파일 ( Initialization Parameter File ) 조회 예제 코드

  |NAME|TYPE|VALUE|
  |:---|:---|:---|
  spfile|string|/u01/app/oracle/product/19.3.0/dbhome_1/dbs/spfileora19c.ora
  - VALUE 값이 비어있는 경우 ( NULL ) == Text Parameter File ( pfile ) 기반으로 열려있는 DB
</br></br></br>
#### Server Parameter File ( spfile )
- ' $ORACLE_BASE/dbs/spfileora19c.ora ' 식의, 파일
  - Binary 파일로서, vi 편집기 등으로 수정 금지
    - ALTER 명령으로 수정
</br></br></br>
#### Text Parameter File ( pfile )
- ' $ORACLE_BASE/dbs/initora19c.ora ' 식의, 파일
- vi 편집기로 수정
```SQL
CRAETE pfile FROM spfile; /* spfile 이용하여, pfile 생성 */
--CREATE spfile FROM pfile; /* pfile 이용하여, spfile 생성 */
--CREATE spfile FROM pfile='/home/oracle/initora19c.ora'; /* 특정 위치에 존재하는 pfile 이용하여, spfile 생성 */


--CRAETE pfile = '/home/oracle/initora19c.ora' FROM spfile; /* 원하는 위치에 생성도 가능 */
```
```
File created.
```
---
</br></br></br>


### Parameter
<!-- - 시스템 레벨 ? -->
#### Static Parameter
```SQL
select * from v$parameter where ISSYS_MODIFIABLE = 'FALSE';
```
> Static Parameter 조회 예제 코드

</br></br></br>
- [초기 파라미터 파일](#initial-parameter-file)  內 수정 가능 ( 초기 파라미터 파일의 특성상, DB 재시작시에 수정값 적용 ( DB 시작시 1회만 열어보기에 ) )
  - Text Parameter File ( pfile ) 경우, vi 편집기로 수정
  - Server Parameter File ( spfile ) 경우, ' ALTER ' 명령문으로 수정
    - ```SQL
      ALTER SYSTEM SET processes=500 SCOPE=SPFILE; /* Server Parameter File ( spfile ) 內 ' processes ' 수정 */
      ```
      ```
      System altered.
      ```
      > 현재 DB, Text Parameter File ( pfile ) 경우 ERR ( ' SCOPE=SPFILE ' == 현재 DB, Server Parameter File ( spfile ) 기반으로 열려있는 경우에만, 사용 가능 )

</br></br></br>
#### Dynamic Parameter
```SQL
--select * from v$parameter where ISSYS_MODIFIABLE != 'FALSE';
select * from v$parameter where ISSYS_MODIFIABLE IN ('IMMEDIATE', 'DEFERRED');
```
> Dynamic Parameter 조회 예제 코드

</br></br></br>
- DB 운영중, Parameter 값을 변경하고 적용 가능
- ```SQL
  ALTER SYSTEM SET open_cursors= 100 SCOPE=MEMORY; /* 현재 메모리에서만 ( Instance ) Parameter 수정 적용 ( 초기 파라미터 파일은 그대로 ) */


  ALTER SYSTEM SET sort_area_size= 1048576 DEFERRED SCOPE=MEMORY; /* ISSYS_MODIFIABLE == DEFERRED 파라미터는, ' DEFERRED ' 키워드 필수 */
  ```
  > DB 재시작시에는, 초기 파라미터 파일 上 내용으로 ( 현재 DB, Text Parameter File ( pfile ) 기반으로 열려있어도, ' SCOPE=MEMORY ' 가능 )

- ```SQL
  ALTER SYSTEM SET open_cursors= 100 SCOPE=BOTH; /* 현재 메모리에서 ( Instance ) Parameter 수정 적용하며, 초기 파라미터 파일 上 ' open_cursors ' 값도 함께 수정 */
  ```
  - 현재 DB, Text Parameter File ( pfile ) 경우 ERR ( ' SCOPE=BOTH ' == 현재 DB, Server Parameter File ( spfile ) 기반으로 열려있는 경우에만 사용 가능 )
    - 현재 DB, Text Parameter File ( pfile ) 경우 ' SCOPE=memory ' 사용만 가능하며, 초기 파라미터 파일은 vi 편집기로 직접 수정 가능
- DEFERRED 파라미터는, ' SCOPE=BOTH ' 사용 가능하나, 현재 Session 아닌, 수정 이후 새접속에서부터 변경값 적용
  - ```SQL
    ALTER SYSTEM SET sort_area_size = 1048576 DEFERRED SCOPE=BOTH; /* ' DEFERRED  ' 키워드 필수 */


    SHOW PARAMETER sort_area_size;
    ```
    |NAME|TYPE|VALUE|
    ---|---|---|
    sort_area_size|integer|65536
    > DB 접속 해제 또는, 새로 접속시 ' 1048576 ' 수정되어 있음을 확인 가능
---
