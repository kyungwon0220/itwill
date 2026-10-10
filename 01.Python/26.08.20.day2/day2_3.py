'''
튜플 
- 인덱싱, 슬라이싱 가능 
- 아이템 추가만 가능 => += 연산자 
- 튜플 변수 사용 가능(Named Tuple)
'''
# 빈튜플 생성 후 아이템 추가 
t = ()
print(t, len(t), type(t))
t += ('파이썬',)
print(t, len(t), type(t))
t += ('SQL', 'C++', 'Unity')
print(t, len(t), type(t))
'''
() 0 <class 'tuple'>
('파이썬',) 1 <class 'tuple'>
('파이썬', 'SQL', 'C++', 'Unity') 4 <class 'tuple'>
'''

# 튜플변수 
user_info = (uId, age, name ) = ('admin', 33, "고길동")
print(user_info[0], uId)
print(user_info[1], age)
print(user_info[2], name)
'''
admin admin
33 33
고길동 고길동
'''

# 자료형 변경 
# list(), tuple()
# str(), join()
my_text = '가나다라마바사'
my_tuple = ('초밥', '알라딘', 'BTS', '해운대', '부산')
my_list = ['파이썬', '자바', 'DB']

# 문자열 => 리스트 => 튜플 
print(my_text.split()) 
print(' '.join(my_text))
my_text2 = ' '.join(my_text)
print(my_text2.split()) 
print(tuple(my_text2.split()))

# 튜플 => 리스트 
print(list(my_tuple))

# 튜플 => 문자열
result1 = str(my_tuple)
result2 = ' '.join(my_tuple)
print(result1, type(result1), len(result1), result1[0])
print(result2, type(result2), len(result2), result2[0])
'''
['가나다라마바사']
가 나 다 라 마 바 사
['가', '나', '다', '라', '마', '바', '사']
('가', '나', '다', '라', '마', '바', '사')
['초밥', '알라딘', 'BTS', '해운대', '부산']
('초밥', '알라딘', 'BTS', '해운대', '부산') <class 'str'> 33 (
초밥 알라딘 BTS 해운대 부산 <class 'str'> 17 초

'''

# PDF 87
tupledata = ('fun-coding1', 'fun-coding2', 'fun-coding3')
print(f"Before : tupledata = {tupledata}")

# 튜플 => 리스트 => 튜플
temp = list(tupledata)
temp.insert(0, 'fun-coding0')
tupledata = tuple(temp)
print(f"After : tupledata = {tupledata}")
'''
Before : tupledata = ('fun-coding1', 'fun-coding2', 'fun-coding3')
After : tupledata = ('fun-coding0', 'fun-coding1', 'fun-coding2', 'fun-coding3')
'''

# PDF 88
# 리스트 정의 (원본 회원 가입 정보)
user_list = [ 'sky_blue', 'admin2026', 'p@ssword', 'membership' ]
print('❤️ ❤️ ❤️ ❤️ ❤️')
print(f' step0 : user_list = {user_list} ')

# 비어있는 튜플 정의 (정제된 아이디를 담을 공간)
user_tuple = ()

# 1. 리스트의 1번째 요소에서 앞 3글자만 추출하여 튜플에 삽입
user_tuple += (user_list[0][:3],)
print(f' step2 : user_tuple = {user_tuple} ')

# 2. 리스트의 2번째 요소에서 뒤쪽 숫자 4글자만 추출하여 튜플에 삽입
user_tuple += (user_list[1][-4:],)
print(f' step3 : user_tuple = {user_tuple} ')

# 3. 리스트의 3번째 요소에서 짝수번째 글자만 추출하여 튜플에 삽입
user_tuple += (user_list[2][1::2],)
print(f' step4 : user_tuple = {user_tuple} ')

# 4. 리스트의 4번째 요소 전체를 튜플의 첫번째(맨 앞) 요소로 삽입
temp = list(user_tuple)
temp.insert(0, user_list[3])
user_tuple = tuple(temp)
print(f' step5 : user_tuple = {user_tuple} ')


'''
 step2 : user_tuple = ('sky',) 
 step3 : user_tuple = ('sky', '2026') 
 step4 : user_tuple = ('sky', '2026', '@sod') 
 step5 : user_tuple = ('membership', 'sky', '2026', '@sod') 
'''
