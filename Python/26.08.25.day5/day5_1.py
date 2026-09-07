'''
환경설정 (vscode+python)
출력문, 입력문 
변수, 연산자, 자료형 
집합형 자료형(list, tuple, set, dictionary)
조건문 (if~elif~else)
반복문 (while, for, comprehention)
기타 제어명령어 (pass, break, continue)
함수 (인자, 반환값 return, *args, **kwargs)
람다함수, 고차원함수(map(), filter())
모듈(표준모듈, 외장모듈, 사용자정의모듈)
import, import ... as ..., from ... import ...
math, random
----
모듈(사용자정의모듈)

변수 < 함수 < 클래스 < 모듈(파일단위) < 패키지(라이브러리-폴더 단위) 

'''

# 사용자정의 모듈 임포트 
import my_tools

# dir() => 모듈안의 함수 목록을 리스트로 반환
print(dir(my_tools))
'''
['__builtins__', '__cached__', '__doc__', '__file__', '__loader__', '__name__', '__package__', '__spec__', 'hello', 'user_info']
'''

# 모듈안의 함수 호출 
print(my_tools.hello('이몽룡'))
print()
my_tools.user_info(name='이몽룡', age=33)

'''
이몽룡 고객님!! 만나서 반갑습니다. 

==================================================
name : 이몽룡
age : 33
'''

# 라이브러리안의 모듈 임포트 테스트 
# import 라이브러리명.모듈명 
# import 라이브러리명.모듈명 as 모듈별칭명
# from 라이브러리명.모듈명 import 함수명 

# import sub.gugu
# print(dir(sub.gugu))
# sub.gugu.gugu_print()

# 별칭이용 테스트 
import sub.gugu as g

print(dir(g))
g.gugu_print()
'''
['__builtins__', '__cached__', '__doc__', '__file__', 
'__loader__', '__name__', '__package__', '__spec__', 
'gugu_print']

구구단 입력 =>5
5 X 1 = 5
5 X 2 = 10
5 X 3 = 15
5 X 4 = 20
5 X 5 = 25
5 X 6 = 30
5 X 7 = 35
5 X 8 = 40
5 X 9 = 45
'''
