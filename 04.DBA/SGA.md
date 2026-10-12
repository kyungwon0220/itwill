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
    - Large Pool
      - ' large_pool_size ' 파라미터로 동적 크기 조정 가능 ( ISSYS_MODIFIABLE == IMMEDIATE (Dynamic Parameter) )
      - Oracle Shared Server 환경시 UGA(User Global Area) 생성 ( 차후 네트워크 진도에서 배울 예정 )
      - RMAN 이용하여 백업, 복구 작업 수행시 사용
      - 병렬 쿼리(Parallel Query) 작업 수행시 사용 ( 차후 튜닝 진도에서 배울 예정 )
    - ![](./mdIMG/JavaPool,StreamsPool.png)
- Database Buffer Cache ( Data Buffer Cache )
  - ![](./mdIMG/DatabaseBufferCache.png)
---
