# 리스트 내포 = List comprehension 
'''
for 문의 명령문에 의해 생성된 데이타가 리스트 안의 데이타로 추가된다

리스트명 = [ 데이타 for 아이템변수 in range() ]
리스트명 = [ 데이타 for 아이템변수1 in range() for 아이템변수2 in range() ]
리스트명 = [ 데이타 for 아이템변수 in range() if ~ ]
리스트명 = [ 데이타 if ~ else ~ for 아이템변수 in range()  ]

'''

# 빈리스트 생성후 for 문을 이용해서 추가하는 방식 
result_list1 = []
for i in range(1, 6):
    result_list1.append(f"{i}번")
print(result_list1)
# ['1번', '2번', '3번', '4번', '5번']

# 리스트 내포 방식
result_list2 = [f"{i}번" for i in range(1, 6)]
print(result_list2)
# ['1번', '2번', '3번', '4번', '5번']


# 리스트안에 이중 for 문 이용 
# 빈리스트 생성후 for~ for~ 문을 이용해서 추가하는 방식 
print('='*30)
gugu_list1 = []
for i in range(2, 5):
    for j in range(1, 10):
        gugu_list1.append(f"{i} x {j} = {i*j}")
print(gugu_list1)

'''
['2 x 1 = 2', '2 x 2 = 4', '2 x 3 = 6', '2 x 4 = 8', '2 x 5 = 10', '2 x 6 = 12', '2 x 7 = 14', '2 x 8 = 16', '2 x 9 = 18', '3 x 1 = 3', '3 x 2 = 6', '3 x 3 = 9', '3 x 4 = 12', '3 x 5 = 15', '3 x 6 = 18', '3 x 7 = 21', '3 x 8 = 24', '3 x 9 = 27', '4 x 1 = 4', '4 x 2 = 8', '4 x 3 = 12', '4 x 4 = 16', '4 x 5 = 20', '4 x 6 = 24', '4 x 7 = 28', '4 x 8 = 32', '4 x 9 = 36']
'''

# 리스트 내포 방식으로 변경 
print('='*30)
gugu_list2 = [ f"{i} x {j} = {i*j}" for i in range(2, 5) for j in range(1, 10)]
print(gugu_list2)

'''
['2 x 1 = 2', '2 x 2 = 4', '2 x 3 = 6', '2 x 4 = 8', '2 x 5 = 10', '2 x 6 = 12', '2 x 7 = 14', '2 x 8 = 16', '2 x 9 = 18', '3 x 1 = 3', '3 x 2 = 6', '3 x 3 = 9', '3 x 4 = 12', '3 x 5 = 15', '3 x 6 = 18', '3 x 7 = 21', '3 x 8 = 24', '3 x 9 = 27', '4 x 1 = 4', '4 x 2 = 8', '4 x 3 = 12', '4 x 4 = 16', '4 x 5 = 20', '4 x 6 = 24', '4 x 7 = 28', '4 x 8 = 32', '4 x 9 = 36']
'''

# PDF 39 
row_colo_list = [ f"row{i}-col{j}" for i in range(1, 3) for j in range(1, 5)]
print(row_colo_list)
'''
['row1-col1', 'row1-col2', 'row1-col3', 'row1-col4', 'row2-col1', 'row2-col2', 'row2-col3', 'row2-col4']
'''

print('='*30)
# 리스트명 = [ 데이타 for 아이템변수 in range() if ~ ]
# 1~30 사이의 숫자 중에서 3의 배수이거나 5의 배수로 구성된 리스트 생성 
num_list1 = []
for i in range(1, 31):
    if (i % 3 == 0) or ( i % 5 == 0) :
        num_list1.append(i)
print(num_list1)
# [3, 5, 6, 9, 10, 12, 15, 18, 20, 21, 24, 25, 27, 30]
print()
num_list2 = [ i for i in range(1, 31) if (i % 3 == 0) or ( i % 5 == 0) ]
print(num_list2)
# [3, 5, 6, 9, 10, 12, 15, 18, 20, 21, 24, 25, 27, 30]

print('='*30)
# for 문 + if ~ else ~
# 리스트명 = [ 데이타1 if ~ else 데이타2  for 아이템변수 in range()  ]

numbers = [1, 2, 3, 4, 5]
result_list = []
for item in numbers:
    if (item % 2 == 0) :
        result_list.append("짝수")
    else:
        result_list.append("홀수")
print(result_list)
# ['홀수', '짝수', '홀수', '짝수', '홀수']

result_list2 = [ "짝수" if (item % 2 == 0) else "홀수" for item in numbers]
print(result_list2)
