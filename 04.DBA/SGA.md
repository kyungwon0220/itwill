### SGA(System Global Area)
![](./mdIMG/SGA.jpg)
- Total System Global Area
  - 현재 DB, Text Parameter File ( pfile ) 기반으로 열려있을시, vi 편집기로 ' sga_max_size ' Parameter 수정 가능
  - 현재 DB, Server Parameter File ( spfile ) 기반으로 열려있는 경우, ALTER 수정 가능
    - ```SQL
      ALTER SYSTEM SET sga_max_size={수정할 값} SCOPE=SPFILE;
      ```
- Fixed Size == Shared Pool + Large Pool + Java Pool + Streams Pool
  - Background 프로세스가 접근하는 DB 및 Instance 상태에 대한 일반적인 정보 ( 오라클이 내부적으로 사용하는 메모리 영역으로서, 오라클사에서 내부를 공개하지 않았다고 한다 )
  - ![](./mdIMG/VariableSize.jpg)
    - Shared Pool
      - ' shared_pool_size ' 파라미터로 동적 크기 조정 가능 ( ISSYS_MODIFIABLE == IMMEDIATE (Dynamic Parameter) )
      - 다양한 유형의 프로그램 데이터를 캐시 해두는 영역
        - Library Cache ( 가칭 ) == SQL, PL / SQL 대한 정보, 실행 계획을 갖고있는 메모리
        - Data Dicionary 정보를 가진, Data Dicionary Cache
      - ![](./mdIMG/SharedPool.jpg) <a id="data-dictionary-cache"></a>
        - Data dictionary Cache == Semantic Check (의미 분석 체크 ) 할때마다, 디스크 I/O 발생 부담으로, ' Data Dictionary ' 정보를 메모리에 올려놓은 공간
          - ```SQL
            SELECT SQL_ID, SQL_TEXT, PARSE_CALLS, LOADS, EXECUTIONS, PLAN_HASH_VALUE, HASH_VALUE
            FROM V$SQL
            ```
            > Shared Pool 內 Library Cache 內 SQL 문장
            - ' PARSE_CALLS ' == Library Cache 요청한 횟수 ( ' EXCUTIONS ' 같이 증가 )
            - ' EXCUTIONS ' == 실행 횟수 ( ' PARSE_CALLS ' 같이 증가 )
            - ' LOADS ' == Library Cache 요청 했으나, 없을시 HARD PARSING 발생하며 증가하는 횟수 ( 실행 계획 생성 )
            - ' PLAN_HASH_VALUE ' == 실행 계획 고유값 ( 이가 같다는 뜻은, 실행 계획이 같다는 의미 ) <a id="plan_hash_value"></a>
    - Large Pool
      - ' large_pool_size ' 파라미터로 동적 크기 조정 가능 ( ISSYS_MODIFIABLE == IMMEDIATE (Dynamic Parameter) )
      - Oracle Shared Server 환경시 UGA(User Global Area) 생성 ( 차후 네트워크 진도에서 배울 예정 )
      - RMAN 이용하여 백업, 복구 작업 수행시 사용
      - 병렬 쿼리(Parallel Query) 작업 수행시 사용 ( 차후 튜닝 진도에서 배울 예정 )
    - ![](./mdIMG/JavaPool,StreamsPool.png)
- Database Buffer Cache ( Data Buffer Cache ) <a id="database-buffer-cache"></a>
  - ' Data Dictionary ' 정보
  - ![](./mdIMG/DatabaseBufferCache.png)
---
