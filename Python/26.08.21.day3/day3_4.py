# 무한루프(반복횟수가 정해져 있지 않은 경우) + break
'''
while True(0이아닌숫자 | 길이가0이아닌문자열 ):
    명령문 
    if문을 이용한 탈출조건식:
        break

'''

# 입력받은 데이타를 리스트에 추가한다 
# 입력데이타가 q 이거나 Q 이면 종료 
# 빈 리스트 정의 
word_list = []

# 무한루프 스타일로 반복문 정의 
# while 1:
#     data = input("데이타 입력 ...(q나 Q이면 종료)").strip()
#     # while 탈출 조건 
#     if (data.upper() == 'Q'):
#         break
#     else:
#         word_list.append(data)
# print()
# print(word_list)
'''
데이타 입력 ...(q나 Q이면 종료)아지랑이
데이타 입력 ...(q나 Q이면 종료)무궁화
데이타 입력 ...(q나 Q이면 종료)Q

['아지랑이', '무궁화']
'''

# continue
#  : 제어문안에서 다음 단계의 명령문 수행

# 1~20 사이의 숫자중에서 3의 배수이거나 7의 배수이면 미출력 
cnt = 0 
while (cnt < 20):
    cnt += 1
    if (cnt % 3 == 0) or (cnt % 7 == 0) :
        continue
    print(cnt, end= " ")
print("\ncontinue 테스트 종료")


# 1~20 사이의 숫자중에서 3의 배수이거나 7의 배수이면 미출력 
# pass 사용
cnt = 0 
while (cnt < 20):
    cnt += 1
    if (cnt % 3 == 0) or (cnt % 7 == 0) :
        pass
    else:
        print(cnt, end= " ")
print("\npass 테스트 종료")

# PDF 16
# 퀴즈 문제 출력 
print("퀴즈 : 파이썬에서 입력문 키워드는?")
# 무한루프 형식으로 정의 
# Input, INPUT, input 모두 정답 처리 
while True:
    # 입력 데이타는 모두 대문자로 변경 
    ans = input("정답을 입력하세요 : ").strip().upper()
    if ans == "INPUT":
        print("정답입니다!")
        break
    else:
        print("틀렸습니다. 다시 시도하세요.")
print("퀴즈를 종료합니다.")
