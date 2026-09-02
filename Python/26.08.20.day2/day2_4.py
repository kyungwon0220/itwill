'''
# 딕셔너리
딕셔너리명 = {키1:값1, 키2:값2, ...}
키값은 독립적이어야한다. 
조회는 키인덱싱만 가능 => 딕셔너리명[키값]

아이템추가 및 수정 => 키값이 없다면 추가, 키값이 있다면 업데이트
딕셔너리명[키값] = 값
'''
myDict1 = {'a':'apple', 10:'ten', '나':'나라장터', 'a':'apart'}
print(myDict1, type(myDict1), len(myDict1))
# {'a': 'apart', 10: 'ten', '나': '나라장터'} <class 'dict'> 3
print(myDict1[10]) # ten <= 키인덱싱
# print(myDict1[20]) # KeyError: 20
myDict1['나'] = '나라' # 수정
myDict1['다'] = '다리미' # 추가
print(myDict1, type(myDict1), len(myDict1))
# {'a': 'apart', 10: 'ten', '나': '나라', '다': '다리미'} <class 'dict'> 4

# update(키변수=값,...) 를 이용한 딕셔너리 아이템 추가 및 수정 
print()
myDict2 = {}
print(myDict2, type(myDict2), len(myDict2))
myDict2.update(강='강황', 모='모바일')
print(myDict2, len(myDict2))
myDict2.update(a='apart', 모='모자')
print(myDict2, len(myDict2))

'''
{} <class 'dict'> 0
{'강': '강황', '모': '모바일'} 2
{'강': '강황', '모': '모자', 'a': 'apart'} 3
'''

# 딕셔너리 요소 삭제 
# 딕셔너리명.pop(키), del 딕셔너리명[키]
dict1 = {'a':'apart', 'b':'banana', 'c':'coffee', 'd':'drama', 'e':'egg'}
print(dict1, len(dict1))
dict1.pop('c')
del dict1['e']
print(dict1, len(dict1))
'''
{'a': 'apart', 'b': 'banana', 'c': 'coffee', 'd': 'drama', 'e': 'egg'} 5
{'a': 'apart', 'b': 'banana', 'd': 'drama'} 3
'''

# 딕셔너리 함수 
# values(), keys(), items()
sports_dict = {"축구":"손흥민", "피겨":"김연아", "농구":"허웅"}
print()
print(sports_dict.keys(), list(sports_dict))
print(sports_dict.values(), list(sports_dict.values()))
print(sports_dict.items(), list(sports_dict.items()))
'''
dict_keys(['축구', '피겨', '농구']) ['축구', '피겨', '농구']
dict_values(['손흥민', '김연아', '허웅']) ['손흥민', '김연아', '허웅']
dict_items([('축구', '손흥민'), ('피겨', '김연아'), ('농구', '허웅')]) [('축구', '손흥민'), ('피겨', '김연아'), ('농구', '허웅')]
'''

# 딕셔너리안의 딕셔너리 
idol_dict = {   'group_name' : '아이브',
                'company' : '스타쉽엔터테인먼트',
                'member' : {
                    'vocal' : ['안유진', '장원영', '리즈', '이서'],
                    'rapper' : ['가을', '레이'],
                    'leader' : '안유진'
                }
            }
print()
print(idol_dict['group_name'])
print(idol_dict['member'])
print(idol_dict['member']['vocal'])
print(idol_dict['member']['vocal'][-1])
print(idol_dict['member']['vocal'][1][1:])
'''
아이브
{'vocal': ['안유진', '장원영', '리즈', '이서'], 'rapper': ['가을', '레이'], 'leader': '안유진'}
['안유진', '장원영', '리즈', '이서']
이서
원영
'''

# 리스트 나 튜플 => 딕셔너리 {인덱스키:값...}
# dict()
# enumerate() => [(인덱스,값)....]
myList = ['사과', '바나나', '딸기']
temp = enumerate(myList)
print(temp)
print(list(temp))
print(dict(enumerate(myList)))
'''
<enumerate object at 0x0000021D483FA480>
[(0, '사과'), (1, '바나나'), (2, '딸기')]
{0: '사과', 1: '바나나', 2: '딸기'}
'''

# 문자열 => 딕셔너리 
mytxt = "도레미파솔라시"
print(enumerate(mytxt))
print(list(enumerate(mytxt)))
print(dict(enumerate(mytxt)))
'''
<enumerate object at 0x000001D0CEACA520>
[(0, '도'), (1, '레'), (2, '미'), (3, '파'), (4, '솔'), (5, '라'), (6, '시')]
{0: '도', 1: '레', 2: '미', 3: '파', 4: '솔', 5: '라', 6: '시'}
'''

# PDF 102
'''
1) 다음 항목을 딕셔너리(dict)으로 선언하여라.
<성인 - 100000 , 청소년 - 70000 , 아동 - 30000>
'''
rate_dict = {'성인':100000, '청소년':7000, '아동':3000}
print()
print(rate_dict)
# 2) 1번 에서 선언한 dict 항목에 <소아 - 0> 항목을 추가하여라
rate_dict['소아'] = 0
# rate_dict.update(소아 = 0)
print(rate_dict)
# 3) 2번의 딕셔너리(dict)에서 Key 항목만 리스트로 저장하여 정렬한 후 튜플로 변경하여라.
temp = list(rate_dict)
temp = tuple(sorted(temp))
print(f"결과 => {temp}")

'''
{'성인': 100000, '청소년': 7000, '아동': 3000}
{'성인': 100000, '청소년': 7000, '아동': 3000, '소아': 0}
결과 => ('성인', '소아', '아동', '청소년')
'''
