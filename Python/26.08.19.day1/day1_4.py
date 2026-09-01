# 문자열 슬라이싱 
# 문자열변수[start:end:step]
# start~(end-1)까지의 데이타문자열값 반환 
# step은 건너뛰기, 기본값이 1
# start 생략시 처음부터, end 생략시는 끝까지
msg = "0123456789"
print(msg[::])
print(msg[0:5])
print(msg[2:5])
print(msg[:5])
print(msg[5:])
print(msg[::2]) # 홀수번째
print(msg[1::2]) # 짝수번째
print(msg[::-1]) # 역순
print(msg[::-2])
'''
0123456789
01234
234
01234
56789
02468
13579
9876543210
97531
'''
print('='*30)
# PDF 38
userIdNum = "881120-1068234"
print("연월일 : ", userIdNum[:6])
print("숫자 : ", userIdNum[7:])
print(userIdNum[:6] + "-" + "*"*6)
'''
연월일 :  881120
숫자 :  1068234
881120-******
'''

# 문자열 포맷팅1 - %서식자 스타일
# % 서식자 : %d, %x, %o, %c, %s, %f, %전체자릿수.소숫점이하자릿수f  
# "%서식자1 문자열~ %서식자2" % (데이타1, 데이타2)
print("10진수 %d , 16진수 %x " % (100, 100))
# 10진수 100 , 16진수 64 
circle_pi = 3.141592653
print("원주율 pi값은 : ==%10.2f==" % circle_pi)
print("원주율 pi값은 : ==%.2f==" % circle_pi)
print("원주율 pi값은 : ==%.4f==" % circle_pi)
'''
원주율 pi값은 : ==      3.14==
원주율 pi값은 : ==3.14==
원주율 pi값은 : ==3.1416==
'''

# 문자열 포맷팅2 - format()
# "문자열~ {} 문자열~ {}".format(변수1, 변수2)
# "문자열~ {인덱스1:서식자1} 문자열~ {인덱스2:서식자2}".format(변수1, 변수2)
# 서식자는 s, d, f, 전체자릿수.소숫점이하자릿수f
# "문자열~ {} 문자열~ {}".format(변수1=초기값1, 변수2=초기값2)
today = "수요일"
yesterday = "목요일"
print("오늘은 {} , 내일은 {}".format(today, yesterday))
print("내일은 {1:s} , 오늘은 {0:s}".format(today, yesterday))
'''
오늘은 수요일 , 내일은 목요일
내일은 목요일 , 오늘은 수요일
'''