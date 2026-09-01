# p_quiz1.txt
'''
문제17: 

사용자가 지불한 금액과 구매한 금액을 입력하면, 
이를 기반으로 잔돈을 계산하여 출력하는 코드를 작성하여라.

- 잔돈은 500원, 100원, 50원, 10원, 1원으로 나누어 계산한다. 
- 각 동전의 개수를 출력하여야 한다. 


출력예시 >>
		지불한 금액을 입력하세요: 30000
		물품 가격을 입력하세요: 25789

		결과 :

		잔돈은 다음과 같습니다:
		500원:  8 개
		100원:  2 개
		50원:  0 개
		10원:  1 개
		1원:  1 개
'''

# 1) 입력받기 => 데이타형 변환
paid_amount = int(input("지불한 금액을 입력하세요: "))
item_price = int(input("물품 가격을 입력하세요: "))

# 2) 잔돈 계산 
change = paid_amount - item_price

# 3) 동전 단위로 계산 (%, // 사용)
five_hundred = change // 500 # 500원 동전
change = change % 500

hundred = change // 100 # 100원 동전
change = change % 100

fifty = change // 50 # 50원 동전
change = change % 50

ten = change // 10 # 10원 동전
change = change % 10

one = change  # 1원 동전

# 4) 출력 레이아웃 
print("\n잔돈은 다음과 같습니다:")
print(f"500원:  {five_hundred} 개")
print(f"100원:  {hundred} 개")
print(f"50원:  {fifty} 개")
print(f"10원:  {ten} 개")
print(f"1원:  {one} 개")