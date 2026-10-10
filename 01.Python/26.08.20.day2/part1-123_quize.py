number_list = [ 5, 1, 2, 2, 3,4, 5, 6, 7, 6, 7, 8, 9, 9, 10, 10 ]

result = sorted(list(set(number_list)), reverse = True)
print(result)

"""
- set() 집합 특으로, 중복 제거
- list 원래의 리스트 형태로
- sorted( reverse = True ) 내림 차순
"""
