# 반복문 
'''
while 
    - 반복횟수가 정해진 경우
    - 무한루프(반복횟수가 정해져 있지 않은 경우) + break
for 
    - in range()
    - in 문자열|리스트|튜플|딕셔너리 

while을 이용한 반복문 (반복횟수가 정해져있다 )

카운트변수 정의 
while <조건식>:
    명령문 
    카운트변수의 증감

'''

# 1~10 사이의 홀수 출력 
cnt = 1
while (cnt <= 10):
    print(f" cnt = {cnt}")
    cnt += 2
print("while 테스트 종료 ")
'''
 cnt = 1
 cnt = 3
 cnt = 5
 cnt = 7
 cnt = 9
while 테스트 종료 
'''

# 10~1 한행으로 출력 
print()
cnt = 10
while (cnt > 0):
    print(cnt, end = " ")
    cnt -= 1
print("\nwhile 테스트 종료 ")
'''
10 9 8 7 6 5 4 3 2 1 
while 테스트 종료 
'''

# PDF Part2 - 3
# print("=" * 30)
# dan = int(input("출력할 구구단의 숫자를 입력하세요...? ").strip())
# cnt = 1
# while (cnt <= 9) :
#     print(f"{dan} X {cnt} = {dan*cnt}")
#     cnt += 1
print("=" * 30)

'''
==============================
출력할 구구단의 숫자를 입력하세요...? 7
7 X 1 = 7
7 X 2 = 14
7 X 3 = 21
7 X 4 = 28
7 X 5 = 35
7 X 6 = 42
7 X 7 = 49
7 X 8 = 56
7 X 9 = 63
==============================
'''


# PDF Part2 - 4
cnt = 5
mark = "* "
while (cnt > 0) :
    print(f"{cnt} {mark*cnt}")
    cnt -= 1
print("=" * 30)
'''
5 * * * * * 
4 * * * * 
3 * * * 
2 * * 
1 * 
'''


# PDF Part2 - 4
txt = "ABCDEFG"
space = "  "
cnt = 0
while (cnt < len(txt)) :
    print(f"{space*cnt}{txt[cnt]}")
    cnt += 1
print("=" * 30)
'''
A
  B
    C
      D
        E
          F
            G
==============================
'''


# while + if 
cnt = 1
while (cnt <= 50) :
    if (cnt % 15 == 0) : print(f"{cnt} => 15의 배수")
    elif (cnt % 5 == 0) : print(f"{cnt} => 5의 배수")
    elif (cnt % 3 == 0) : print(f"{cnt} => 3의 배수")
    else : pass # 비실행문 pass
    cnt += 1
print("=" * 30)
'''
3 => 3의 배수
5 => 5의 배수
6 => 3의 배수
9 => 3의 배수
10 => 5의 배수
12 => 3의 배수
15 => 15의 배수
18 => 3의 배수
20 => 5의 배수
21 => 3의 배수
24 => 3의 배수
25 => 5의 배수
27 => 3의 배수
30 => 15의 배수
33 => 3의 배수
35 => 5의 배수
36 => 3의 배수
39 => 3의 배수
40 => 5의 배수
42 => 3의 배수
45 => 15의 배수
48 => 3의 배수
50 => 5의 배수
==============================
'''

# PDF 6
cnt = 1
while (cnt <= 30) :
    # 5의 배수이면 줄바꿈 
    print(f"{cnt:^3}", end="")
    if (cnt % 5 == 0) : print()
    cnt += 1
print()
print("=" * 30)

# PDF 7 
# 숫자 리스트 정의 후 평균 구하기 
num_list = [100, 55, 50, 30, 25, 10, 67, 88, 45] 
avg = sum(num_list)/len(num_list)
print(f"{num_list} 의 평균은? {avg:.2f} ")

# 평균값보다 크면 리스트의 아이템 출력 
print("평균보다 큰 값은? ", end=" ")
cnt = 0
while (cnt < len(num_list)) :
    if (num_list[cnt] >= avg) :
       print(num_list[cnt], end = " ") 
    cnt += 1
print()
print("=" * 30)
'''
[100, 55, 50, 30, 25, 10, 67, 88, 45] 의 평균은? 52.22 
평균보다 큰 값은?  100 55 67 88 
==============================
'''

# 중첩 while 문 

cnt1 = 1
# cnt2 = 3
while (cnt1 <= 3):
    print(f"cnt1 = {cnt1}")

    cnt2 = 3
    while (cnt2 > 0):
        print(f"\tcnt2 = {cnt2}")
        cnt2 -= 1
    
    cnt1 += 1
    print('='*5)

'''
cnt1 = 1
        cnt2 = 3
        cnt2 = 2
        cnt2 = 1
=====
cnt1 = 2
        cnt2 = 3
        cnt2 = 2
        cnt2 = 1
=====
cnt1 = 3
        cnt2 = 3
        cnt2 = 2
        cnt2 = 1
=====
'''

# PDF 9 
# 전체 구구단 출력 

dan = 2
while (dan <= 9) :
    print(f"   {dan}단")

    cnt = 1
    while ( cnt <= 9) :
        print(f"{dan} X {cnt} = {dan*cnt}")
        cnt += 1
    print()

    dan += 1

print('-'*20)