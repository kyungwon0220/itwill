# for문을 이용한 반복문 
'''
for 아이템변수 in range(start, end, step):
    명령문

range(start, end, step)
    : 숫자 생성기 => range 객체 => list(), tuple() 형변환 
    : start ~ end-1 까지 step 만큼 숫자 생성 
    : start 생략시 0, step 생략시 1

'''
print(range(10), list(range(10)))
print(list(range(11, 21)))
print(list(range(2, 21, 2)))
print(list(range(10, 0, -1)))
'''
range(0, 10) [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
[11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
'''

# for 문을 이용한 출력 
for i in range(11, 21, 4):
    print(f" i = {i}")
'''
 i = 11
 i = 15
 i = 19
'''

# 문자열 유효성 함수 
# isalnum(), isisdigit(), isdecimal() 
print('123'.isalnum()) # True
print('!&***124'.isalnum()) # False
print('123'.isdigit()) # True
print('123'.isdecimal()) # True
print('123강아지apple'.isdecimal()) # False
print('강아지apple'.isalpha()) # True
'''
True
False
True
True
False
True
'''

# PDF 20 
'''
# 빈리스트 생성 
num_list = []

# for 문을 이용해서 입력횟수 제한 
for i in range(10):
    data = input('데이타를 입력하세요?...').strip()

    # 리스트에 삽입되는 데이타는 숫자이어야 한다
    if data.isdigit() or ((data[0] == "-") and data[1:].isdigit()):
        num_list.append(data)
        print("데이타가 추가되었음\n")

    # 리스트의 길이 제한 
    if len(num_list) == 3 :
        break

print(f" 리스트 출력 => {num_list}")
'''

'''
데이타를 입력하세요?...45
데이타가 추가되었음

데이타를 입력하세요?...-90
데이타가 추가되었음

데이타를 입력하세요?...akjflkldfa
데이타를 입력하세요?...100
데이타가 추가되었음

 리스트 출력 => ['45', '-90', '100']
'''

# 중첩 for 문 
for i in range(1, 4):
    print(f" i = {i}")
    for j in range(3, 0, -1):
        print(f" \t j = {j}")
    print()
print("중첩 for 문 테스트 종료")

'''
i = 1
         j = 3
         j = 2
         j = 1

 i = 2
         j = 3
         j = 2
         j = 1

 i = 3
         j = 3
         j = 2
         j = 1

중첩 for 문 테스트 종료

'''

# 전체 구구단 출력 
for dan in range(2, 10):
    print(f" {dan} 단")
    for cnt in range(1, 10):
        print(f"{dan} X {cnt} = {dan*cnt}")
    print()
print("전체 구구단 출력 종료1")

# PDF 22
print()
for i in range(1, 8, 3):
    for j in range(1, 10):
        print(f"{i:^2} X {j:^3} = {i*j:^3}    ", end = "")
        print(f"{(i+1):^2} X {j:^3} = {(i+1)*j:^3}    ", end = "")
        print(f"{(i+2):^2} X {j:^3} = {(i+2)*j:^3}    ", end = "")
        print()
    print()
print("전체 구구단 출력 종료2")

'''
1  X  1  =  1     2  X  1  =  2     3  X  1  =  3     
1  X  2  =  2     2  X  2  =  4     3  X  2  =  6     
1  X  3  =  3     2  X  3  =  6     3  X  3  =  9     
1  X  4  =  4     2  X  4  =  8     3  X  4  = 12     
1  X  5  =  5     2  X  5  = 10     3  X  5  = 15     
1  X  6  =  6     2  X  6  = 12     3  X  6  = 18     
1  X  7  =  7     2  X  7  = 14     3  X  7  = 21     
1  X  8  =  8     2  X  8  = 16     3  X  8  = 24     
1  X  9  =  9     2  X  9  = 18     3  X  9  = 27     

4  X  1  =  4     5  X  1  =  5     6  X  1  =  6     
4  X  2  =  8     5  X  2  = 10     6  X  2  = 12     
4  X  3  = 12     5  X  3  = 15     6  X  3  = 18     
4  X  4  = 16     5  X  4  = 20     6  X  4  = 24     
4  X  5  = 20     5  X  5  = 25     6  X  5  = 30     
4  X  6  = 24     5  X  6  = 30     6  X  6  = 36     
4  X  7  = 28     5  X  7  = 35     6  X  7  = 42     
4  X  8  = 32     5  X  8  = 40     6  X  8  = 48     
4  X  9  = 36     5  X  9  = 45     6  X  9  = 54     

7  X  1  =  7     8  X  1  =  8     9  X  1  =  9     
7  X  2  = 14     8  X  2  = 16     9  X  2  = 18     
7  X  3  = 21     8  X  3  = 24     9  X  3  = 27     
7  X  4  = 28     8  X  4  = 32     9  X  4  = 36     
7  X  5  = 35     8  X  5  = 40     9  X  5  = 45     
7  X  6  = 42     8  X  6  = 48     9  X  6  = 54     
7  X  7  = 49     8  X  7  = 56     9  X  7  = 63     
7  X  8  = 56     8  X  8  = 64     9  X  8  = 72     
7  X  9  = 63     8  X  9  = 72     9  X  9  = 81     

전체 구구단 출력 종료2
'''