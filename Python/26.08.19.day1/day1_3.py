'''
# PDF 26
# 1) 데이타 입력받기 (문자열=>정수)
num1 = int(input("첫번째 숫자를 입력하세요..."))
num2 = int(input("두번째 숫자를 입력하세요..."))
# 2) 구분선 출력 
print("="*40)
# 3) 계산 결과 출력
print(num1, "+", num2, "=", num1+num2)
print(num1, "-", num2, "=", num1-num2)
print(num1, "*", num2, "=", num1*num2)
print(num1, "/", num2, "=", num1/num2)
'''

'''
첫번째 숫자를 입력하세요...10
두번째 숫자를 입력하세요...5
========================================
10 + 5 = 15
10 - 5 = 5
10 * 5 = 50
10 / 5 = 2.0
'''

'''
# PDF 27
userName = input("학생명... ")
userAge = input("나이...(정수로 입력)")
print("="*40)
print("학생이름 :" + userName)
print("나이 :" + userAge + " 세")
print("태어난 해: " , 2026-int(userAge) , "년")
'''

'''
학생명... 이몽룡
나이...(정수로 입력)18
========================================
학생이름 :이몽룡
나이 :18 세
태어난 해:  2008 년
'''

# 연산자 
# 산술연산자 +, -, *, /, //(정수몫), %(정수나머지)
# 대입연산자 +=, -=, *=, /=
cnt = 0 
print("cnt = ", cnt)
cnt += 10  # cnt = cnt + 10
print("cnt = ", cnt)
cnt *= 2  # cnt = cnt * 2
print("cnt = ", cnt)
'''
cnt =  0
cnt =  10
cnt =  20
'''
# 관계 연산자(비교 연산자) : <, >, >=, <=, ==, !=
# 논리 연산자 : and, or, not 
userId = "admin"
userPwd = "1234"
print(userId == "admin")
print((userId == "admin") or (userPwd=="가나다라"))
print((userId == "admin") and (userPwd=="가나다라"))
print(not(userPwd=="가나다라"))
'''
True
True
False
True
'''
# 문자열 인덱싱 - 특정 위치의 값 반환 
# 문자열변수[인덱스값] - 첫번째 위치는 0, 마지막 위치는 -1
msg = "도레미파솔라시"
print(msg[0])
print(msg[3])
print(msg[-1])
print(msg[-4])
'''
도
파
시
파
'''