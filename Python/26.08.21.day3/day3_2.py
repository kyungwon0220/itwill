# in / not in 연산자 
'''
아이템데이타 in 문자열|리스트|튜플|딕셔너리|집합 
아이템데이타 not in 문자열|리스트|튜플|딕셔너리|집합 
=> True | False 반환 
'''

# 문자열 적용 
print('a' in 'apple')
print('b' in 'apple')
'''
True
False
'''

# 튜플 적용 
myTuple = ('강아지', '고양이', '기린')
print('호랑이' not in myTuple)
print('기린' not in myTuple)
'''
True
False
'''

# 딕셔너리 적용 => 키 우선 
myDict = { "a":"apple", "b":"banana", "c":"cat"}
print("a" in myDict) # True
print("banana" in myDict) # False
print("banana" in myDict.values()) # True


# PDF - 141
# 객관식 샘플 출력 
sample_txt = '''
다음 중 파이썬의 논리 연산자가 아닌 것은?
1. and
2. or
3. not
4. Plus
'''
print(sample_txt)

# 입력 데이타 
ans = input("정답 번호를 입력하세요: ").strip()

# if ... in 메세지 출력 
# 정답은 4, Plus, plus 
ans_list = ['4', 'Plus', 'plus']
if ans in ans_list: # (ans == '4') or (ans == 'Plus') or (ans == 'plus')
    print("정답입니다!")
else:
    print('틀렸습니다. 정답은' + ' , '.join(ans_list) + ' 입니다')

