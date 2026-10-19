### 초기 파라미터 파일 ( Initialization Parameter File ) <a id="initial-parameter-file"></a>
- ' SELECT * FROM v$parameter ' 실행하여 확인이 가능한 약 500개의 파리미터들 中, Oracle 기본값이 아닌, 초기 세팅이 필요한 Parameter 값을 세팅하는 File
  - [Control File](261007.md#control-file) 위치 정보 소유
  - 주로, ' control_files ', ' compatible ', ' db_name ', ' undo_tablespace ' Parameter 정도를 필수로 세팅한다
  - 오라클이 관리하는 Hidden Parameter 존재 ( 차후 튜닝 진도에서 배울 예정 )
- 생성시에 Path 미지정시, ' $ORACLE_HOME/dbs/ ' Default 경로에 생성
- DB 시작시, 참조 우선 순위는 Server Parameter File ( spfile ) > Text Parameter File ( pfile ) > 둘다 없을시, ERR
- ```SQL
  SHOW PARAMETER spfile
  ```
  > DB 시작시에 사용한, ' 초기 파라미터 파일 ' 조회 예제 코드

  |NAME|TYPE|VALUE|
  |:---|:---|:---|
  spfile|string|/u01/app/oracle/product/19.3.0/dbhome_1/dbs/spfileora19c.ora
  - VALUE 값이 비어있는 경우 ( NULL ) == ' Text Parameter File ( pfile ) ' 기반으로 열려있는 DB
</br></br></br>
#### Server Parameter File ( spfile )
- ' Text Parameter File ( pfile 또는 Static Parameter File 稱 ) ' 보다, Oracle 권장
- Binary ( 이진 형식 ) 파일로서, vi 편집기 등으로 수정 금지 ( ' ALTER ' 명령으로 수정 필수 )
```SQL
CREATE spfile FROM pfile; /* pfile 이용하여, spfile 생성 */
CREATE spfile FROM pfile='/home/oracle/initora19c.ora'; /* 특정 위치에 존재하는 pfile 이용하여, spfile 생성 */
```
</br></br></br>
```SQL
ALTER SYSTEM SET processes=500 SCOPE=SPFILE;
ALTER SYSTEM SET open_cursors=100 SCOPE=MEMORY;
ALTER SYSTEM SET open_cursors=100 SCOPE=BOTH;
```
> ' ALTER SYSTEM SET ' == System Level 수정
- ' SCOPE=SPFILE ' == 현재 세션이 아닌, Server Parameter File ( spfile ) 내용 수정
  - 현재 DB, Server Parameter File ( spfile ) 기반으로 열려있는 경우에만, 사용 가능 ( ' Text Parameter File ( pfile 또는 Static Parameter File 稱 ) ' 기반으로 DB 열려있는 경우 ERR )
- ' SCOPE=MEMORY ' == 현재 세션에서만 적용되게, 수정 ( DB 재시작시에는, ' 초기 파라미터 파일 ' 내용으로 DB Open )
  - ' Text Parameter File ( pfile 또는 Static Parameter File 稱 ) ' 기반으로 DB 실행시 ' SCOPE=MEMORY ' 사용만 가능 ( ' 초기 파라미터 파일 ' 수정 필요시, 편집기로 파일을 직접 수정 )
- ' SCOPE=BOTH ' == 현재 세션과, Server Parameter File ( spfile ) 내용 수정
</br></br></br>
#### Text Parameter File ( pfile 또는 Static Parameter File 稱 ) <a id="text-parameter-file"></a>
- vi 편집기로 수정 ( ' ALTER ' 명령으로 수정 불가 )
  - File 내용 수정시, 수정 내용은 다음 DB 시작시부터 적용 ( DB 시작시에 ' 초기 파라미터 파일 ' 1회만 열어보기에, 수정 내용을 현재 Session 적용 불가 )
```SQL
CRAETE pfile FROM spfile; /* spfile 이용하여, pfile 생성 */
CRAETE pfile = '/home/oracle/initora19c.ora' FROM spfile; /* 원하는 위치에 생성도 가능 */
```
---
</br></br></br>


### Parameter
#### Static Parameter <a id="static-parameter"></a>
- [초기 파라미터 파일 ( Initialization Parameter File )](#initial-parameter-file) 內 수정으로만, 수정 가능
  - Static Parameter 값을 수정시, 수정 내용은 다음 DB 시작시부터 적용 ( ' 초기 파라미터 파일 ', DB 시작시 1회만 열어보기에, 수정 내용을 현재 Session 적용 불가 )
```SQL
SELECT * FROM v$parameter WHERE issys_modifiable = 'FALSE';
```
> ' ISSYS_MODIFIABLE = 'FALSE' ' == Static Parameter 조회 예제 코드

</br></br></br>
```SQL
--ALTER SYSTEM SET processed=500; /* Static 파라미터 수정 불가 ERR */
ALTER SYSTEM SET processes=500 SCOPE=SPFILE; /* ' SCOPE=SPFILE ' 사용하여, ' 초기 파라미터 파일 ' 통해서만, 수정 가능 */
```
```
System altered.
```
</br></br></br>
#### Dynamic Parameter <a id="dynamic-parameter"></a>
- DB 운영중에 Parameter 수정하고, 적용 가능
```SQL
--SELECT * FROM v$parameter WHERE issys_modifiable != 'FALSE';
SELECT * FROM v$parameter WHERE issys_modifiable IN ('IMMEDIATE', 'DEFERRED');
```
> Dynamic Parameter 조회 예제 코드

</br></br></br>
```SQL
ALTER SYSTEM SET open_cursors=100 SCOPE=MEMORY; /* ' SCOPE=MEMORY ' == 현재 세션에서만 적용되게, 수정 */


ALTER SYSTEM SET open_cursors=100 SCOPE=BOTH; /* ' SCOPE=BOTH ' == 현재 세션과, Server Parameter File ( spfile ) 내용 수정 */
```
</br></br></br>
##### Dynamic Parameter 中 ' ISSYS_MODIFIABLE = DEFERRED ' Parameter
- ALTER ' 명령으로 수정시, ' DEFERRED ' 키워드 입력 필수
- ' SCOPE=BOTH ' 수정시, 수정한 현재 Session 아닌, 수정 後 새접속부터 수정 내용 적용
```SQL
SELECT * FROM v$parameter WHERE issys_modifiable = 'DEFERRED';
```
> Dynamic Parameter 中 DEFERRED Parameter 조회 예제 코드

</br></br></br>
```SQL
ALTER SYSTEM SET sort_area_size = 1048576 DEFERRED SCOPE=MEMORY; /* ' SCOPE=MEMORY ' 사용하여, 현재 세션에만 적용도 가능 */
ALTER SYSTEM SET sort_area_size = 1048576 DEFERRED SCOPE=BOTH;


SHOW PARAMETER sort_area_size;
```
|NAME|TYPE|VALUE|
---|---|---|
sort_area_size|integer|65536
> DB 접속 해제 後 재접속 또는, 새로운 세션에서 ' SHOW PARAMETER sort_area_size; ' 실행하여 확인시, VALUE ' 1048576 ' 수정되어 있다
---
