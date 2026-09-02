# 집합
'''
중복데이타를 허용하지 않는다. 
순서가 없다 => 인덱싱X, 슬라이싱X
집합연산과 관련된 함수와 연산자 

집합명 = {값1, 값2, ...}
집합명 = set()

집합요소 추가 - add(), update([값1, 값2...])
집합요소 삭제는 ? remove()
'''
set1 = { 100, 200, 300, 400, 500}
set2 = set() 
print(set1, len(set1), type(set1))
print(set2, len(set2), type(set2))
set2.add('무궁화')
set2.update(['개나리', '장미', '백합'])
print(set2, len(set2))
set2.remove('개나리')
print(set2, len(set2))


'''
{400, 100, 500, 200, 300} 5 <class 'set'>
set() 0 <class 'set'>
{'무궁화', '개나리', '백합', '장미'} 4
{'무궁화', '백합', '장미'} 3
'''

# PDF 114
shohoku_set = {"강백호", "서태웅", "채치수", "송태섭", "강백호"}
print(f"- 북산고교 명단 : {shohoku_set} ")
print(f"- 현재 등록된 총 선수 인원수 : {len(shohoku_set)} 명")
# 선수 추가 등록
shohoku_set.add('정대만')
print(f"- 정대만 추가 후 명단 : {shohoku_set}")
shohoku_set.update(['윤대협', '이정환'])
print(f"- 라이벌 추가 후 명단 : {shohoku_set}")
#  Delete : 명단에서 선수 제외
member = '윤대협'
shohoku_set.remove(member)
print(f"- {member} 제외 후 최종 명단 : {shohoku_set}")

'''
- 북산고교 명단 : {'서태웅', '송태섭', '채치수', '강백호'} 
- 현재 등록된 총 선수 인원수 : 4 명
- 정대만 추가 후 명단 : {'강백호', '채치수', '정대만', '송태섭', '서태웅'}
- 라이벌 추가 후 명단 : {'이정환', '윤대협', '강백호', '채치수', '정대만', '송태섭', '서태웅'}
-  윤대협 제외 후 최종 명단 : {'서태웅', '채치수', '강백호', '이정환', '송태섭', '정대만'}
'''

# 집합 연산
# |(합집합) , -(차집합) , &(교집합) , ^(대칭차집합)
# union(), difference(), intersection(), symmetric_differnce()
set1 = {'최', '박', '선우', '김', '이'}
set2 = {'신', '장', '윤', '김', '이'}
print()
print(f" 합집합 => {set1 | set2}")
print(f" 차집합 => {set1 - set2}")
print(f" 교집합 => {set1 & set2}")
print(f" 대칭차집합 => {set1 ^ set2}")
'''
 합집합 => {'신', '김', '선우', '박', '윤', '장', '이', '최'}
 차집합 => {'최', '선우', '박'}
 교집합 => {'이', '김'}
 대칭차집합 => {'신', '윤', '선우', '박', '최', '장'}
'''

# PDF 120 

# 4개의 컨텐츠를 집합으로 선언 
netflix_shows = {"오징어게임", "더글로리", "지옥", "킹덤", "스위트홈"}
tving_shows = {"더글로리", "삼시세끼", "지옥", "대탈출", "환승연애"}
disney_shows = {"무빙", "카지노", "지옥", "스타워즈", "어벤져스"}
recommended_shows = {"오징어게임", "더글로리", "무빙", "나의아저씨", "미스터션샤인"}
print("👍 👍 👍 👍")
print(f"- 넷플릭스 콘텐츠 명단 : {netflix_shows}")
print(f"- 티빙 콘텐츠 명단 : {tving_shows}")
print(f"- 디즈니플러스 명단 : {disney_shows}")
print(f"- 친구의 강력 추천 명단 : {recommended_shows}")
print("[OTT 스마트 추천 시스템 연산 결과]")
print(f"1. 가성비 최고 추천작 (추천 & 넷플릭스 & 티빙) : {recommended_shows & netflix_shows & tving_shows }")
print(f"2. 모든 플랫폼 공통 콘텐츠 (넷플릭스 & 티빙 & 디즈니) : {disney_shows & netflix_shows & tving_shows }")
print(f"3. 별도 개별 구매 필요 콘텐츠 (추천 - 나머지 전체) :  {recommended_shows - netflix_shows - tving_shows - disney_shows  }")
print(f"4. 현재 넷플릭스나 티빙 중 내가 시청 가능한 전체 콘텐츠 목록 :  {netflix_shows | tving_shows }")
'''
1. 가성비 최고 추천작 (추천 & 넷플릭스 & 티빙) : {'더글로리'}
2. 모든 플랫폼 공통 콘텐츠 (넷플릭스 & 티빙 & 디즈니) : {'지옥'}
3. 별도 개별 구매 필요 콘텐츠 (추천 - 나머지 전체) :  {'미스터션샤인', '나의아저씨'}
4. 현재 넷플릭스나 티빙 중 내가 시청 가능한 전체 콘텐츠 목록 :  {'대탈출', '오징어게임', '지옥', '킹덤', '환승연애', '더글로리', '스위트홈', '삼시세끼'}
'''

# PDF 123 
print( '='*30)
number_list = [ 5, 1, 2, 2, 3, 4, 5, 6, 7, 6, 7, 8, 9, 9, 10, 10 ]
print(f"Before : {number_list}")

# 중복데이타 삭제 : 리스트 => 집합 => 리스트 
temp = set(number_list)
number_list = list(temp)
# 내림차순 형태로 정렬
number_list = sorted(number_list, reverse=True)

print(f"After : {number_list}")
'''
Before : [5, 1, 2, 2, 3, 4, 5, 6, 7, 6, 7, 8, 9, 9, 10, 10]
After : [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
'''

# 제어문 - 조건문, 반복문, 기타명령어(break, continue, pass)
'''
조건문 
- if <조건식> 
- if <조건식> ~ else ~
- if <조건식1> ~ elif <조건식2> ~  else ~

들여쓰기 주의 => indentation Error
'''

# 짝수 홀수 판별 1
print('='*20)
myNum = 5
if (myNum % 2 == 0) :
    print(f" {myNum}는 짝수")
if (myNum % 2 != 0) : print(f" {myNum}는 홀수")

print("짝수 홀수 판별 테스트 종료1")

# 짝수 홀수 판별 2
print('='*20)
myNum = 6
if (myNum % 2 == 0) : print(f" {myNum}는 짝수")
else : print(f" {myNum}는 홀수")
print("짝수 홀수 판별 테스트 종료2")

# 다중 조건문 
'''
if 조건식1 :
    명령문1
elif 조건식2 :
    명령문2    
else :
    명령문3
'''

# PDF 131
userAge = int(input("당신의 나이를 입력해주세요? ..."))
msg = ""
if (userAge <= 7) : msg = "영유아" 
elif (userAge <= 13) : msg = "초등학생" 
# elif (7 < userAge <= 13) : msg = "초등학생" 
# elif (userAge > 7) and (userAge <= 13) : msg = "초등학생" 
elif (userAge <= 16) : msg = "중학생"
elif (userAge <= 19) : msg = "고등학생"
else : msg = "성인"
print(msg)

