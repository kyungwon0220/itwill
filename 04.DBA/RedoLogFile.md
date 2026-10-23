### Redo Log File <a id="redo-log-file"></a>
- [Redo Log Buffer](SGA.md#redo-log-buffer) 內 Redo Entry, [LGWR](261013.md#lgwr) 프로세스가 기록하는 File
- Data 모든 변경 사항 기록
- Instance 및 Media Failure 발생시 복구 방식 제공
- 순환식 구조로서, 최소 2개 이상의 Redo Log Group 필수
  - 2개의 Group 존재 상태에서, Group 삭제 시도시, 불가 ERR
- ```SQL
  SELECT a.group#, b.sequence#, a.member, b.members, b.bytes/1024/1024 mb, b.archived, b.status, b.first_change#, b.next_change#
  FROM v$logfile a, v$log b
  WHERE a.group# = b.group#
  ORDER BY 1;
  ```
  |GROUP#|STATUS|. . .|
  |---:|:---|---|
  1|CURRENT|. . .|
  2|INACTIVE|. . .|
  3|ACTIVE|. . .|
  4|UNUSED|. . .|
  . . .|. . .|. . .|
  - ' STATUS ' == ' CURRENT ' == 현재 Redo Log 작성중인 Group
  - ' STATUS ' == ' ACTIVE ' == Redo Log 작성은 마쳤으나, [Check Point](#check-point-event) 미완료 상태 ( Dirty 버퍼가, 아직 Data 파일에 Write 작업되지 않은 상태로서, Instance Recovery 時 필요하여 덮어쓰기 사용 및 삭제 불가 상태 )
  - ' STATUS ' == ' INACTIVE ' == Check Point 완료로, Instance Recovery 불필요한 상태 ( Write 끝난 상태로서, [Log Switch](261013.md#log-switch) 발생시, 재사용 가능 상태 )
  - ' STATUS ' == ' UNUSED ' == Group 생성 後 아직 사용하지 않은 상태
</br></br></br>
#### Redo Log File Group 추가
```SQL
ALTER DATABASE ADD LOGFILE GROUP 4 ('u01/app/oracle/oradata/ORA19C/redo04.log', '/u01/app/oracle/fast_recovery_area/onlinelog/redo04.log') SIZE 200M; /* 4번 Group 추가 */
ALTER DATABASE ADD LOGFILE GROUP 5 /u01/app/oracle/oradata/ORA19C/redo05.log SIZE 200M; /* 다중화 없이, 단일 Group 추가 가능 */
```
> 일반적으로 모든 그룹별 용량은 동일하게끔, ' /u01/app/oracle/fast_recovery_area/onlinelog/ ' 경로에 MEMBER 다중화

</br></br></br>
#### Redo Log File MEMBER 추가
```SQL
ALTER DATABASE ADD LOGFILE MEMBER
'/u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/redo05.log' TO GROUP 5; /* 5번 그룹에, MEMBER 추가 */
```
> Group 5 內 기존 파일과 동일해야 하므로, 용량은 지정 불가

</br></br></br>
#### Redo Log File Group, MEMBER 삭제
- [Control File](261007.md#control-file) 내용 上 ' STATUS ' == ' INACTIVE ', ' STATUS ' == ' UNUSED ' 상태인 그룹만 삭제 가능
  - ' Control File ' 내용 上 ' STATUS ' == ' CURRENT ' 그룹은, 현재 사용중인 파일로서 삭제 불가 ERR
  - ' Control File ' 내용 上 ' STATUS ' == ' ACTIVE ' 그룹은, 아직 Write 대기중이므로, 삭제 불가
- Group 삭제시, Group 內 멤버들도 삭제된다
  - Group 內 하나의 멤버만 존재시, MEMBER 삭제가 아닌, Group 삭제 필수
- 삭제 後 실제 파일은, OS 內 수동으로 직접 삭제 ( 차후, 혼돈 방지를 위해서 즉시 삭제 권장 )
```SQL
ALTER DATABASE DROP LOGFILE GROUP 5; /* Group 5 전체 삭제 ( MEMBER 포함 ) */


ALTER DATABASE DROP LOGFILE MEMBER '/u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/redo04.log'; /* ' redo04.log ' 멤버만 삭제 */
```
---
