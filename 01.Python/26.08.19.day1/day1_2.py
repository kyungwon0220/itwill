'''
변수명 주의 사항 
- 예약어, 함수명, 라이브러리
- 소문자로 지정 => 일반 변수, 함수명, 모듈명
- 대문자로 지정 => 클래스명  
'''
import keyword 
print(keyword.kwlist) # 파이썬 예약어 목록 리스트 
# 파이썬 예약어 목록 리스트 갯수 확인
print(len(keyword.kwlist)) 
'''
['False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']
35
'''
# 자료형 
# int, float, str, boolean(True, False)
# type() => 자료형 알아보기 함수 
x, y, z = 100, 3.14, True
txt = "Hello python"
print(x, type(x))
print(y, type(y))
print(z, type(z))
print(txt, type(txt))
'''
100 <class 'int'>
3.14 <class 'float'>
True <class 'bool'>
Hello python <class 'str'>
'''
# 줄바꿈(\n) 이 있는 형태의 문자열 변수 정의 
anthem = """애국가
동해물과 백두산이 
마르고 닳도록
"""
print(anthem)
# 논리형 => True, False
# bool() => 데이타를 논리형으로 변경해주는 함수 
# False로 인식하는 값 
# : 0, None, 길이가0인문자열, [], (), {}, set()
x, y, z1, z2 = 0, 3.14, "Hello", ""
xx, yy, zz1, zz2 = bool(x), bool(y), bool(z1), bool(z2)
print(x, xx)
print(y, yy)
print(z1, zz1)
print(z2, zz2)
'''
0 False
3.14 True
Hello True
 False
'''

# 자료형 변환 함수 - int(), float(), str(), bool()
x, y = "10", "-3.14"
print("======")
print(float(x), float(y)) # 10.0 -3.14
# print(int(x), int(y)) # ValueError
print(int(x), int(float(y))) # 10 -3

# 입력문 
# 변수명 = input("입력메세지") => 문자열 변수
userName = input("고객명 => ")
print(userName + "님 오늘도 좋은 하루되세요!!!")