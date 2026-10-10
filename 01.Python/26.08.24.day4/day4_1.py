# PDF 40 
'''
[ 데이타 for ~ for]
[ 데이타 for ~ if ~]
[ 데이타1 if ~ else  데이타2 for ~ ]
'''
scores = [55, 80, 45, 92, 70]
scores_result1 = [ f"{item} 점" for item in scores]
scores_result2 = [ "Pass" if item >=60 else "Fail" for item in scores]
print(scores_result1)
print(scores_result2)

# 함수 
'''
변수 < 함수 < 모듈(파일단위) < 라이브러리(패키지-폴더단위)

내장함수 - 파이썬에서 자동으로 호출해서 사용하는 함수 
사용자정의 함수 - 직접 정의하고 호출하는 함수 

모듈 
 - 표준 모듈 : 파이썬에 이미 지정된 모듈들. 
              math, random, csv, sqlite
 - 외장 모듈 : 설치가 필요한 모듈들. pip install ~ 
              pandas, numpy, sklearn, seaborn 
'''

# 사용자정의 함수의 형식 
'''
def 함수명(인자 , 인자=초기값, *args, **kwargs):
    명령문...
    return 값 | 계산식 | 변수 | 함수

# 함수호출
함수명()    
함수명(인자값1, 인자값2 ... )
함수명(변수=값)
''' 

# 함수정의1 - 인자X, 반환값X
# 특정 구구단 출력 함수 정의 
def guguPrint():
    num = int(input("출력할 구구단을 입력하세요...").strip())
    for i in range(1, 10):
        print(f" {num} 곱하기 {i} 는 {num*i}")
    print("구구단 함수 호출을 종료합니다.\n\n")

# 함수 호출
# guguPrint()

'''
출력할 구구단을 입력하세요...5
 5 곱하기 1 는 5
 5 곱하기 2 는 10
 5 곱하기 3 는 15
 5 곱하기 4 는 20
 5 곱하기 5 는 25
 5 곱하기 6 는 30
 5 곱하기 7 는 35
 5 곱하기 8 는 40
 5 곱하기 9 는 45
구구단 함수 호출을 종료합니다.
'''

# 함수정의2 - 인자O, 반환값X
# 특정 구구단 출력 함수 정의 
def guguPrint2(num):
    for i in range(1, 10):
        print(f" {num} 곱하기 {i} 는 {num*i}")
    print("구구단 함수 호출을 종료합니다.\n\n")

# num = int(input("출력할 구구단을 입력하세요...").strip())

# 인자값을 전달하는 함수 호출
# guguPrint2(num)
# guguPrint2() # TypeError: guguPrint2() missing 1 required positional argument: 'num'

guguPrint2(7)

# PDF 46
def cal(x, y):
    print(f" {x} + {y} = {x+y}")
    print(f" {x} - {y} = {x-y}")
    print(f" {x} * {y} = {x*y}")
    print(f" {x} / {y} = {x/y:.2f}")
    print(f" {x} % {y} = {x%y}")

cal(10, 5)
# cal(10)


# PDF 48
def starPrint(n):
    mark = '* '
    for i in range(1, n+1):
        print( mark * i)
    print("="*40)

starPrint(5)
starPrint(10)