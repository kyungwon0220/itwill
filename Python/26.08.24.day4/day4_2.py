# 함수의 반환값 return 
'''
 return 값 | 계산식 | 변수 | 함수

 return 되는 데이타가 여러개인 경우 => 튜플
 return 데이타1, 데이타2, .... => (데이타1, 데이타2 ...)

'''

# 인자O, return 1개 
def hello1(user):
    return f'{user}님, 오늘도 좋은 하루되세요\n'

# print() 함수 내부에서 함수를 호출     
print(hello1('홍길동'))
print(hello1('고길동'))
'''
홍길동님, 오늘도 좋은 하루되세요

고길동님, 오늘도 좋은 하루되세요
'''

# 인자O, return 여러개 
def hello2(user, msg):
    result1 = f'{user}님, 환영합니다\n'
    result2 = f'{user}님, {msg}\n'
    return result1, result2

print(hello2('이순신', '좋은 하루되세요'))
'''
('이순신님, 환영합니다\n', '이순신님, 좋은 하루되세요\n')
'''

txt = hello2('이순신', '좋은 하루되세요')
print(type(txt), txt[0])
# <class 'tuple'> 이순신님, 환영합니다

# 인자에 초기값이 있는 형태 
'''
def 함수명(인자1=값1, 인자2=값2 ...)
    명령문 
'''

# 인자의 합을 구하는 함수 정의 
def calc(x=0, y=0, z=0):
    return f'{x} + {y} + {z} = {x+y+z}'

print(calc())
print(calc(5))
print(calc(5, 10))
print(calc(5, 10, 15))

# 초기값이 지정된 인자랑 초기값이 없는 인자가 함께 정의된 함수 
def starPrint(n, mark='* '):
# def starPrint(mark='* ', n): # SyntaxError
    for i in range(1, n+1):
        print( mark * i)
    print("="*40)

starPrint(3)
starPrint(4, '!')

# PDF 56
def say_myself(name, old, man=True):
    print(f"나의 이름은 {name}입니다.")
    print(f"나이는 {old}살입니다.")
    if man: print("남자입니다.")
    else: print("여자입니다")

say_myself('홍길동', 20)
print()
say_myself('이민정', 15, False)

'''
나의 이름은 홍길동입니다.
나이는 20살입니다.
남자입니다.

나의 이름은 이민정입니다.
나이는 15살입니다.
여자입니다
'''


# 가변인자 (인자의 수가 정해져 있지 않음)
'''
def 함수명(*args)
    args는 튜플로 작동
    명령문 

함수명() => 빈튜플 ()    
함수명(값1) => 튜플 1개 (값1, )    
함수명(값1, 값2...) => 튜플 1개 (값1, 값2...)    
'''

def studentName(*args):
    print(f" 전체 수강생 목록 => {args}, 총인원수 => {len(args)}\n")
    if len(args):
        for member in args:
            print(member)
    else:
        print("수강생이 없습니다.")
    print("="*30)
    

studentName()
studentName('고길동')
studentName('고길동', '박길동', '이길동')

'''
전체 수강생 목록 => (), 총인원수 => 0

수강생이 없습니다.
==============================
 전체 수강생 목록 => ('고길동',), 총인원수 => 1

고길동
==============================
 전체 수강생 목록 => ('고길동', '박길동', '이길동'), 총인원수 => 3

고길동
박길동
이길동
==============================
'''

# pdf 60 
def studentName2(*members):
    if len(members):
        for i in range(len(members)):
            print(f"{i+1}번째 학생 : {members[i]}")
    else:
        print("학생이 없습니다.")
    print("="*30)

studentName2()
studentName2('김지민', '이영희', '은지원')
'''
학생이 없습니다.
==============================
1번째 학생 : 김지민
2번째 학생 : 이영희
3번째 학생 : 은지원
==============================
'''

# 일반인자, 초기값이있는인자, 가변인자가 함께 정의되어 있는 함수 정으 
'''
def 함수명(인자1, 인자2=값, *가변인자):
    명령문

'''

def introduce(stname, grade=1, *info):
    print(f"학생명 => {stname}")
    print(f"학년 => {grade}")
    for i in info:
        print(i)
    print()

introduce('김철수')
introduce('박철수', 3)
introduce('이철수', 2, '컴퓨터공학과', '서울 거주')
'''
학생명 => 김철수
학년 => 1

학생명 => 박철수
학년 => 3

학생명 => 이철수
학년 => 2
컴퓨터공학과
서울 거주
'''

# PDF 64
mytuple = (12, 56, -90)
print(max(mytuple))
print(min(mytuple))

def min_max_max(choice, *args):
    if choice == 'min':
        print(f"최소값은? {min(args)}")
    elif choice == 'max':
        print(f"최대값은? {max(args)}")
    else:
        print('오류발생')

min_max_max('더하기', 10, 56, -90, 1000)
min_max_max('min', 10, 56, -90, 1000)
min_max_max('max', 10, 56, -90, 1000)
'''
오류발생
최소값은? -90
최대값은? 1000
'''

# 키워드아규먼트 **kwargs
'''
kwargs => keyword arguments

def 함수명(**kwargs):
    kwargs는 딕셔너리 
    명령문 

함수명(키변수=값, ...)

'''

def intro(**kwargs):
    print(type(kwargs), len(kwargs))
    print(kwargs)
    for k, v in kwargs.items():
        print(f"{k} => {v}")
    print()

intro()
intro(userId="admin", userName="홍길동")
intro(userId="manager", userName="고길동", userAge=22)

'''
<class 'dict'> 0
{}

<class 'dict'> 2
{'userId': 'admin', 'userName': '홍길동'}
userId => admin
userName => 홍길동

<class 'dict'> 3
{'userId': 'manager', 'userName': '고길동', 'userAge': 22}
userId => manager
userName => 고길동
userAge => 22
'''

# 일반인자, *args, **kwargs
'''
def 함수명(일반인자, *args, **kwargs):
    args는 튜플 
    kwargs는 딕셔너리 
    명령문 
'''

def make_user(userName, *args, **kwargs):
    print(f"userName = {userName}")
    print(f"args = {args}")
    print(f"kwargs = {kwargs}")
    print()

make_user('홍길동')
make_user('홍길동', 12, '경영학과')
make_user('홍길동', 12, '경영학과', address='부산', mobile='010-1234-5678')

'''
userName = 홍길동
args = ()
kwargs = {}

userName = 홍길동
args = (12, '경영학과')
kwargs = {}

userName = 홍길동
args = (12, '경영학과')
kwargs = {'address': '부산', 'mobile': '010-1234-5678'}
'''