'''
# PDF 72
# 1) 띠 리스트 생성 
zodian_txt = "원숭이, 닭, 개, 돼지, 쥐, 소, 범, 토끼, 용, 뱀, 말, 양"
zodiac_list = zodian_txt.split(", ")
print(zodiac_list)

# 띠 구하기 알고리즘 
# 띠인덱스 = 태어난년도%12
# 2) 태어난년도 입력 받기 => 정수형으로 변경 
birth_year = int(input("태어난 년도를 입력하세요? ... "))

# 3) 띠인덱스 구하기 
birth_idx = birth_year % 12

# 4) 출력 
print(f"{birth_year}년도 출생은 {zodiac_list[birth_idx]}띠입니다.")
'''

'''
태어난 년도를 입력하세요? ... 2026
2026년도 출생은 말띠입니다.
'''

# 리스트안의 리스트 = 중첩 리스트 
# 중첩리스트 조회 => 리스트명[행인덱스][열인덱스]
grade_list = [
    ['고길동', '김영희', '이둘리'], # 학생이름
    [100, 80, 85], # 국어 점수
    [55, 70, 35], # 영어 점수
    [80, 80, 100] # 수학 점수
]
print(grade_list)
print(grade_list[0])
print(grade_list[0][0], grade_list[1][0], grade_list[2][0], grade_list[-1][0])
# 국어점수의 총점과 평균 출력
# sum(리스트)
print(f" 국어 : 총점 {sum(grade_list[1])} 평균 {sum(grade_list[1])/len(grade_list[1]):.2f}")
# 특정 학생의 총점과 평균 출력
total = grade_list[1][-1] + grade_list[2][-1] + grade_list[3][-1]
print(f" {grade_list[0][-1]} : 총점 {total} 평균 {total/3:.2f}")


'''
[['고길동', '김영희', '이둘리'], [100, 80, 85], [55, 70, 35], [80, 80, 100]]
['고길동', '김영희', '이둘리']
고길동 100 55 80
국어 : 총점 265 평균 88.33
이둘리 : 총점 220 평균 73.33
'''

# PDF 78 
drink_inventory = [
    ["콜라", 5, 1500],
    ["사이다", 3, 1200],
    ["보리차", 10, 2000],
    ["삼다수", 30, 800],
    ["캔커피", 7, 2500],
]

print("=== 편의점 음료수 재고 관리 프로그램 ===")
print('-'*30)
print("[상품 정보 확인]")
idx = 0
print(f"- {idx+1}번 상품명 : {drink_inventory[idx][0]}, {drink_inventory[idx][-1]}원, 재고 {drink_inventory[idx][1]} ")
print('-'*30)
print("[재고 가치 평가 결과]")
print(f"- {drink_inventory[idx][0]} 재고의 총 가치 : {drink_inventory[idx][1]*drink_inventory[idx][-1]} 원")

'''
=== 편의점 음료수 재고 관리 프로그램 ===
------------------------------
[상품 정보 확인]
- 1번 상품명 : 콜라, 1500원, 재고 5 
------------------------------
[재고 가치 평가 결과]
- 콜라 재고의 총 가치 : 7500 원
'''

# 튜플 
'''
Create : 
() 
(데이타,) 
(데이타1,데이타2...)
데이타1,데이타2...
'''

mytuple1 = ()
mytuple2 = (1,) # 튜플원소 한개인 경우 마지막에 쉼표(,) 
mytuple3 = ('하나', 100, True)
mytuple4 = '하나', 100, True
print(mytuple1, type(mytuple1))
print(mytuple2, type(mytuple2))
print(mytuple3, type(mytuple3))
print(mytuple4, type(mytuple4))
'''
() <class 'tuple'>
(1,) <class 'tuple'>
('하나', 100, True) <class 'tuple'>
('하나', 100, True) <class 'tuple'>
'''

