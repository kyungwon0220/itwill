import random

# print(random.__doc__)
# print(dir(random))
'''
['BPF', 'LOG4', 'NV_MAGICCONST', 'RECIP_BPF', 'Random', 'SG_MAGICCONST', 
'SystemRandom', 'TWOPI', '_ONE', '_Sequence', 
'__all__', '__builtins__', '__cached__', '__doc__', '__file__', '__loader__', '__name__', 
'__package__', '__spec__', '_accumulate', '_acos', '_bisect', '_ceil', '_cos', '_e', '_exp', '_fabs', '_floor', '_index', '_inst', '_isfinite', '_lgamma', '_log', '_log2', '_os', '_parse_args', '_pi', '_random', '_repeat', '_sha512', '_sin', '_sqrt', '_test', '_test_generator', '_urandom', 
'betavariate', 'binomialvariate', 'choice', 'choices', 'expovariate', 'gammavariate', 'gauss', 'getrandbits', 'getstate', 'lognormvariate', 'main', 'normalvariate', 'paretovariate', 'randbytes', 'randint', 
'random', 'randrange', 'sample', 'seed', 'setstate', 'shuffle', 'triangular', 'uniform', 'vonmisesvariate', 'weibullvariate']
'''

# 숫자 생성 테스트 
print(random.randint(1, 10)) 
# 리스트내포 + 랜덤숫자생성기
num_list1 = [ random.randint(0,1) for _ in range(5)]
num_list2 = [ random.uniform(-1,1) for _ in range(5)]
num_list3 = [ round(random.uniform(-1,1), 2) for _ in range(5)]
print(num_list1) 
print(num_list2) 
print(num_list3) 

'''
8
[1, 0, 0, 0, 0]
[-0.2536088303819106, -0.5565940448382665, -0.9547540565639723, 0.0765604023309967, -0.6634299787134068]
[0.18, 0.57, -0.79, -0.78, -0.48]
'''

# 리스트안에서 뽑기 - random.sample(리스트, 갯수)
student_list = ['철수', '영희', '길동', '미미', '영철', '은정', '흥민']
print(random.sample(student_list, 2)) # ['은정', '영희']

# 리스트 섞기 - random.shuffle(리스트)
student_list = ['철수', '영희', '길동', '미미', '영철', '은정', '흥민']
print()
print(student_list)
random.shuffle(student_list)
print(student_list)


# 1~45 로또번호 6개 뽑기(중복 숫자 가능)
def make_lotto1():
    lotto_list = [ random.randint(1, 45) for _ in range(6)]
    lotto_list = sorted(lotto_list)
    print(f'로또 번호 : {lotto_list}')

make_lotto1()
make_lotto1()
make_lotto1()
'''
로또 번호 : [30, 31, 38, 42, 43, 44]
로또 번호 : [15, 36, 38, 41, 45, 45]
로또 번호 : [19, 19, 20, 40, 43, 45]
'''

# 1~45 로또번호 6개 뽑기(중복 숫자 불가능)
def make_lotto2():
    num_list = list(range(1, 46))
    lotto_list = random.sample(num_list, 6)
    lotto_list = sorted(lotto_list)
    print(f'로또 번호2 : {lotto_list}')

print()
make_lotto2()
make_lotto2()
make_lotto2()
'''
로또 번호2 : [7, 13, 17, 23, 30, 37]
로또 번호2 : [4, 16, 20, 25, 32, 43]
로또 번호2 : [5, 16, 18, 23, 31, 34]
'''

# PDF 15

def choiceMember(daylist, studentlist):
    for day in daylist:
        choice_member = random.sample(studentlist, 2)
        print(f'{day} 청소 당번은? {' , '.join(choice_member)}')
    print()

stList = [ '김철수', '홍길동', '기대주', '이동백', '하민수', '김영희', '소민주', '신은수' ]
print('='*30)
choiceMember(['월','화','수','목','금'], stList)
choiceMember(['월','수','금'], stList)

'''
월 청소 당번은? 홍길동 , 소민주
화 청소 당번은? 소민주 , 홍길동
수 청소 당번은? 김철수 , 김영희
목 청소 당번은? 김철수 , 신은수
금 청소 당번은? 이동백 , 신은수

월 청소 당번은? 김영희 , 신은수
수 청소 당번은? 신은수 , 홍길동
금 청소 당번은? 소민주 , 김철수
'''

print('='*30)
# PDF 16

def quizGame(quiz_list):
    # 퀴즈 뽑기 
    quiz = random.choice(quiz_list)
    # quiz = random.sample(quiz_list, 1)
    
    # 퀴즈 출력 
    print(f"문제 : {quiz['question']}")
    for option in quiz['options']:
        print('\t' + option)

    # 입력 데이타 
    ans = int(input('정답 번호를 입력하세요: ').strip())

    # 정답 판정 
    if ans == quiz['answer']:
        print('정답입니다!')
    else:
        print('틀렸습니다')
    print()


quiz_list = [
 {
 "question": "파이썬에서 난수를 생성하는 모듈은?",
 "options": ["1. math", "2. random", "3. time", "4. os"],
 "answer": 2
 },
 {
 "question": "리스트에서 요소를 무작위로 하나 뽑는 함수는?",
 "options": ["1. shuffle", "2. randint", "3. choice", "4. sample"],
 "answer": 3
 },
 {
 "question": "파이썬의 실행 결과값이 항상 짝수로 반올림되는 함수는?",
 "options": ["1. round", "2. ceil", "3. floor", "4. trunc"],
 "answer": 1
 }
]
quizGame(quiz_list)
print()
