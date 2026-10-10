'''
PDF 57 퀴즈 
'''
# 0) 다중라인이 있는 문자열을 변수로 정의 
anthem = '''(1절)
동해물과 백두산이 마르고 닳도록
하느님이 보우하사 우리나라만세

(후렴) 무궁화 삼천리 화려강산 
대한사람 대한으로 길이 보전하세

(2절)
남산위에 저 소나무 철갑을 두른듯
바람서리 불변함은 우리기상 일세
(후렴)무궁화 삼천리 화려강산 대한사람 대한으로 길이보전하세'''

print(anthem)
print()
# 1) 애국가 1,2 절에서 무궁화는 몇 번 나올까?
print(f"무궁화는 애국가 1~2절에서 {anthem.count('무궁화')}번 나옵니다")
print()
# 2) 애국가 1,2 절에서 '소나무'의 위치 인덱스 값은?
# find(), index()
print(f"애국가 1~2절에서 \"소나무\"의 인덱스 위치는 {anthem.find('소나무')}입니다")
print()
# 3) 애국가 1,2 절에서 줄바꿈 없이 출력하여라
# \n => 공백화 , replace()
anthem2 = anthem.replace('\n','')
print(anthem2)
# 4) 애국가 1절에서 아래 문자열만 출력하여라(슬라이싱, find() 활용)
start_idx = anthem2.find('동해물과')
end_idx = anthem2.find('만세')+2
print()
print(anthem2[start_idx:end_idx])
# 5) 애국가에서 일부 슬라이싱 한 후 아래와 같이 출력하여라 ( join() 활용)
# 구분문자열.join(문자열변수)
start_idx = anthem2.find('동해물과')
end_idx = anthem2.find('마르고')+3
anthem3 = anthem2[start_idx:end_idx].replace(' ','')
print()
print('='.join(anthem3))

'''
집합형 자료형 : 리스트[], 딕셔너리 {}, 튜플 (), 집합 {}
조건문 
반복문 
break, continue, pass

Creat : 생성
Read : 인덱싱, 슬라이싱
Update : 추가, 내용수정
Delete : 아이템별 삭제 
'''

# 리스트 생성 - 초기값이 있는 형태 
# len() => 리스트의 길이 조회 함수
# type() => 데이타형 조회 함수
mylist = [ 12, "강아지", True, 3.14 ]
print(mylist)
print(len(mylist), type(mylist))
'''
[12, '강아지', True, 3.14]
4 <class 'list'>
'''

# 빈리스트 생성 후 아이템 추가 
# append(데이타), insert(index, 데이타)
# extend(추가리스트), + 연산자 이용 => 여러개의 리스트 추가 
foodList = []
print('='*10)
print(foodList, len(foodList))
foodList.append('라면')
foodList.append('볶음밥')
print(foodList, len(foodList))
foodList.insert(0, '우동')
print(foodList, len(foodList))
foodList.extend(['공기밥', '김밥', '초밥'])
print(foodList, len(foodList))
foodList = foodList + ['제육볶음', '고등어조림']
print(foodList, len(foodList))

'''
[] 0
['라면', '볶음밥'] 2
['우동', '라면', '볶음밥'] 3
['우동', '라면', '볶음밥', '공기밥', '김밥', '초밥'] 6
['우동', '라면', '볶음밥', '공기밥', '김밥', '초밥', '제육볶음', '고등어조림'] 8
'''

# 아이템 값 교체 
# 리스트명[인덱스] = 데이타
# 리스트명[start:end] = [데이타1, 데이타2 ...]
mylist = [ 12, "강아지", True, 3.14 ]
print()
print(mylist[0])
mylist[0] = 100
print(mylist)
print(mylist[2:])
mylist[2:] = ['이몽룡', '춘향이']
print(mylist)
'''
12
[100, '강아지', True, 3.14]
[True, 3.14]
[100, '강아지', '이몽룡', '춘향이']
'''

# 아이템 삭제 
# remove(값), pop(인덱스), pop(), clear()
# del 리스트명[인덱스]
# del 리스트명
city_list = ['제주', '서울', '부산', '대구', '대전', '공주', '마산', '세종']
print()
print(len(city_list), city_list)
city_list.remove('서울')
city_list.pop(1)
city_list.pop() 
print(len(city_list), city_list)
del city_list[0]
print(len(city_list), city_list)
city_list.clear()
print(len(city_list), city_list)
del city_list
# print(len(city_list), city_list) 
# NameError: name 'city_list' is not defined

'''
8 ['제주', '서울', '부산', '대구', '대전', '공주', '마산', '세종']
5 ['제주', '대구', '대전', '공주', '마산']
4 ['대구', '대전', '공주', '마산']
0 []
'''

# 리스트 정렬 
# 리스트명.sort(), 리스트명.reverse()
# sorted(리스트명, reverse=True)
num_list = [100, 20, -90, 10000, 4, 67]
print()
print(num_list)
print(sorted(num_list)) # 오름차순
print(num_list)
print(sorted(num_list, reverse=True)) # 내림차순
print(num_list[::-1]) # 역순 
print(num_list)
num_list.sort() # 원본 리스트에 바로 반영
print(num_list)


'''
[100, 20, -90, 10000, 4, 67]
[-90, 4, 20, 67, 100, 10000]
[100, 20, -90, 10000, 4, 67]
[10000, 100, 67, 20, 4, -90]
[67, 4, 10000, -90, 20, 100]
[100, 20, -90, 10000, 4, 67]
[-90, 4, 20, 67, 100, 10000]
'''

# PDF 70 
# 1) 빈리스트 생성 
yourList = []
# 2) 입력문을 이용해서 리스트 원소 추가 
print('='*20)
item = input("좋아하는 음식은?...")
yourList.append(item)

yourList.append(input("최근 본 영화는?..."))
yourList.append(input("좋아하는 가수는?..."))

# 3) 리스트 출력 
print(f'당신에 관한 리스트 : {yourList}')

'''
좋아하는 음식은?...떡볶이
최근 본 영화는?...호프
좋아하는 가수는?...블랙핑크
당신에 관한 리스트 : ['떡볶이', '호프', '블랙핑크']
'''