# for 문을 이용한 아이템 순회 
'''
for 아이템변수 in 문자열|리스트|튜플 :
    명령문 

for 키변수 in 딕셔너리 :
    명령문

for 키변수, 값변수 in 딕셔너리.items() :
    명령문

'''

# 리스트 순회 
grade_list = [90, 25, 67, 45, 80]
count = 1 
for grade in grade_list:
    if (grade >= 60) :
        print(f" {count} 번 => {grade} 점 => 합격")
    else:
        print(f" {count} 번 => {grade} 점 => 불합격")
    count += 1
print('리스트 순회 테스트 종료')

'''
 1 번 => 90 점 => 합격
 2 번 => 25 점 => 불합격
 3 번 => 67 점 => 합격
 4 번 => 45 점 => 불합격
 5 번 => 80 점 => 합격
리스트 순회 테스트 종료
'''

# 딕셔너리 순회 1
word_dict = { 'a':'apple', 'b':'banana', 'c':'coffee'}
print('='*30)
for key in word_dict:
    print(f" {key} => {word_dict[key]}")

'''
 a => apple
 b => banana
 c => coffee
'''

# 딕셔너리 순회 2
print('='*30)
for k, v in word_dict.items():  # [(키, 값), ...]
    print(f" {k} => {v}")
'''
 a => apple
 b => banana
 c => coffee
'''

# PDF 27 
print('='*30)
word_dict = {'a': 'africa', 's': 'say', 'c': 'coffee', 'd': 'drama', 'y':'yes'}
tot = 0 # a 글자가 있는 아이템의 갯수 누적 변수 
for k, v in word_dict.items():  # [(키, 값), ...]
    if 'a' in v:
        print(f" {k} => {v}")
        tot += 1
print(f' 총갯수는? {tot}')
'''
a => africa
 s => say
 d => drama
 총갯수는? 3
'''

# 중첩 리스트의 데이타 순회 1 => 인덱스 방식 
sample_list = [ [1, 2, 3, 4],
                ['a', 'b', 'c', 'd'],
                ['홍길동', '춘향이', '이몽룡', '고길동']]

for i in range(3):
    for j in range(4):
        print(f" {i} , {j} => {sample_list[i][j]}", end="     ")
    print()
    print()
print()

'''
 0 , 0 => 1      0 , 1 => 2      0 , 2 => 3      0 , 3 => 4     

 1 , 0 => a      1 , 1 => b      1 , 2 => c      1 , 3 => d     

 2 , 0 => 홍길동      2 , 1 => 춘향이      2 , 2 => 이몽룡      2 , 3 => 고길동  

'''


# 중첩 리스트의 데이타 순회 2 => 튜플 변수 방식  
sample_list = [ [1, 2, 3, 4],
                ['a', 'b', 'c', 'd'],
                ['홍길동', '춘향이', '이몽룡', '고길동']]

for (a, b, c, d) in sample_list:
    print(f" a => {a}   b => {b}   c => {c}   d => {d}")
print()

'''
 a => 1   b => 2   c => 3   d => 4
 a => a   b => b   c => c   d => d
 a => 홍길동   b => 춘향이   c => 이몽룡   d => 고길동
'''

# PDF 31
stGradeList = [ ['김태희', 30, 50, 55],
                ['신민아', 50, 90, 80],
                ['박지민', 50, 90, 40],
                ['김소희', 60, 50, 56],
                ['윤준희', 90, 88, 66] ]

print("="*50)
print(" 학생이름   국어  영어  수학  합계  평균")
print("="*50)

for (name, kor, eng, math) in stGradeList:
    tot = kor + eng + math
    avg = tot/3
    print(f"   {name}    {kor}    {eng}    {math}   {tot}  {avg:.2f}")

'''
==================================================
 학생이름   국어  영어  수학  합계  평균
==================================================
   김태희    30    50    55   135  45.00
   신민아    50    90    80   220  73.33
   박지민    50    90    40   180  60.00
   김소희    60    50    56   166  55.33
   윤준희    90    88    66   244  81.33    
'''

# 학생 이름이 희로 끝나는 데이타만 출력하여라
print()
stGradeList = [ ['김태희', 30, 50, 55],
                ['신민아', 50, 90, 80],
                ['박지민', 50, 90, 40],
                ['김소희', 60, 50, 56],
                ['윤준희', 90, 88, 66] ]

print("="*30)
print(" 학생이름   국어  영어  수학")
print("="*30)

for (name, kor, eng, math) in stGradeList:
    if (name[-1] == "희"):
        print(f"   {name}    {kor}    {eng}    {math}")

'''
==============================
 학생이름   국어  영어  수학
==============================
   김태희    30    50    55
   김소희    60    50    56
   윤준희    90    88    66
'''