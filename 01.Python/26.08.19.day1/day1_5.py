# 문자열 포맷팅3 - f-string 방식 
# f"문자열~ {변수1:서식자1} 문자열~ {변수2:서식자2}"
today = "수요일"
yesterday = "목요일"
circle_pi = 3.141592653
print(f"오늘은 {today} , 내일은 {yesterday}")
print(f"원주율 pi 값은? {circle_pi}")
print(f"원주율 pi 값은? {circle_pi:.3f}")
'''
오늘은 수요일 , 내일은 목요일
원주율 pi 값은? 3.141592653
원주율 pi 값은? 3.142
'''
# 여백을 주거나 대체문자 지정 : >, <, ^
# f"문자열~ {변수:대체문자>전체자릿수}"
# f"문자열~ {변수:대체문자<전체자릿수}"
# f"문자열~ {변수:대체문자^전체자릿수}"
math, kor, eng = 80, 70, 95
print(f"국어 :{kor}점,수학 :{math}점,영어 :{eng}점")
print(f"국어 :{kor:>5}점,수학 :{math:^5}점,영어 :{eng:<5}점")
print(f"국어 :{kor:#>5}점,수학 :{math:#^5}점,영어 :{eng:#<5}점")
'''
국어 :70점,수학 :80점,영어 :95점
국어 :   70점,수학 : 80  점,영어 :95   점
국어 :###70점,수학 :#80##점,영어 :95###점
'''

# PDF 48 
math, kor, eng = 55, 86, 77
avg = (math + kor + eng)/3
print(f"국어 : {kor}")
print(f"영어 : {eng}")
print(f"수학 : {math}")
print(f"평균 : {avg:.2f}")
print("평균 : %.2f" % avg)
print("평균 : {0:.2f}".format(avg))
'''
국어 : 86
영어 : 77
수학 : 55
평균 : 72.67
평균 : 72.67
평균 : 72.67
'''

# 문자열 함수 
# 문자열변수.함수명(옵션)
# count(), find(), index() 
# upper(), lower(), title()
# replace()
# strip()
# split() : 문자열 => 리스트 
# 샘플 문자열 더미 데이타 생성 (https://www.lipsum.com/feed/html)
sample_txt = """Lorem ipsum dolor sit amet, consectetur 
adipiscing elit. Aenean velit massa, 
ullamcorper ut lorem a, venenatis varius risus. 
Fusce odio nulla, eleifend ac consectetur porttitor, 
vestibulum in arcu. Aliquam hendrerit facilisis justo, 
id mattis tellus consequat quis. Sed congue, 
ipsum a consequat lobortis, justo dui feugiat nibh, 
ac rutrum ipsum nisi sit amet ipsum. 
Aliquam ornare venenatis enim, 
vel consectetur eros eleifend vel. Sed ante lorem, 
egestas fringilla pulvinar in, porta vitae felis. 
"""
print(f"ipsum 글자의 빈도수는? {sample_txt.count('ipsum')}")
print(f"dolor 글자의 인덱스 시작 위치는? {sample_txt.find('dolor')}")
'''
ipsum 글자의 빈도수는? 4
dolor 글자의 인덱스 시작 위치는? 12
'''
print(sample_txt[:20].title())
'''
Lorem Ipsum Dolor Si
'''
print('='*20)
print(sample_txt.replace('lorem', '개나리'))
print('='*20)
sample_txt_list = sample_txt.split()
print("="*30)
print(len(sample_txt_list))
print(sample_txt_list)

# 여백 없애기 
sample_word = "   H e  l l o w   "
print(f"###{sample_word}###")
print(f"###{sample_word.strip()}###")
print(f"###{sample_word.rstrip()}###")
print(f"###{sample_word.replace(' ','')}###")
'''
###   H e  l l o w   ###
###H e  l l o w###
###   H e  l l o w###
###Hellow###
'''
# join() 함수 
# 구분문자열.join(문자열변수)
msg = "가나다라마바사"
print(" , ".join(msg))
print("/".join(msg)[:-2])
'''
가 , 나 , 다 , 라 , 마 , 바 , 사
가/나/다/라/마/바
'''

# 수업 자료실 - 퀴즈 폴더
# naver.me/5eDgFM9W
# 0819