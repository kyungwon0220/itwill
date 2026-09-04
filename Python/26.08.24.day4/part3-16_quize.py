import random

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

ran = random.randrange(len(quiz_list)-1)

print(quiz_list[ran]["question"])
ans = int(input(quiz_list[ran]["options"]))

if (ans == quiz_list[ran]["answer"]):
    print("정답입니다!")
else:
    print("땡 !")
