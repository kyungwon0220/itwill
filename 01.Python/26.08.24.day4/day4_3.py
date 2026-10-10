# 람다함수 
'''
함수변수 = lambda 인자:명령문 

함수변수명(인자)

map(람다식, 리스트|튜플)
filter(람다식, 리스트|튜플)
'''

# 일반함수 스타일 
# round(실수, 반올림에해당하는소숫점자릿수)
def avg(kor, eng, math):
    return round((kor+eng+math)/3, 3)

print(avg(10, 45, 60)) # 38.333

# 람다함수 스타일 
avg_f = lambda kor, eng, math:round((kor+eng+math)/3, 3)
print(avg_f(10, 45, 60)) 


# PDF 68 
f1 = lambda txt:print(txt[0] + '*'*len(txt[1:]))

f1('홍길동')
f1('admin56784')
f1('동해물과백두산이')

'''
홍**
a*********
동*******
'''

# PDF 19 
f2 = lambda kor, eng, math:print(f"국어:{kor} 영어:{eng} 수학:{math} 총점:{kor+eng+math} 평균:{(kor+eng+math)/3:.2f}")
f2(100, 45, 67)
f2(87, 45, 55)
'''
국어:100 영어:45 수학:67 총점:212 평균:70.67
국어:87 영어:45 수학:55 총점:187 평균:62.33
'''

# filter(함수명|람다식 , 리스트/튜플) => filter 객체 => 반복문이나 list()
# 리스트/튜플 로부터 함수명|람다식 을 적용해서 True인 데이타만 추출 


# 특정 리스트에서 양수만 추출하는 함수 정의 
# 일반함수 스타일 
def filter_pos(numlist):
    result_list = []
    for num in numlist:
        if num > 0:
            result_list.append(num)
    return result_list

numlist = [ 10, 55, -90, -78, 100, 0, -9]
print(filter_pos(numlist))
# [10, 55, 100]

# filter() + 일반함수 
def posNum(num):
    return num > 0

numlist = [ 10, 55, -90, -78, 100, 0, -9]
print(filter(posNum, numlist)) # <filter object at 0x000002414ACA6590>
print(list(filter(posNum, numlist))) # [10, 55, 100]
for num in filter(posNum, numlist):
    print(num)
'''
10
55
100
'''

# filter() + 람다함수  
numlist = [ 10, 55, -90, -78, 100, 0, -9]
print(filter(lambda num : num > 0, numlist))
print(list(filter(lambda num : num > 0, numlist)))
for num in filter(lambda num : num > 0, numlist):
    print(num)
'''
<filter object at 0x000001C3A87F6DA0>
[10, 55, 100]
10
55
100
'''

# PDF 75
# 일반함수 스타일 
def filter_length(wordlist):
    result_list = []
    for word in wordlist:
        if len(word) >= 4:
            result_list.append(word)
    return result_list

words = ["apple", "it", "python", "ai", "banana", "go", "developer", "sql"]
print(filter_length(words))
# ['apple', 'python', 'banana', 'developer']


# filter() + 일반함수 
def wordlength(word):
    return len(word) >= 4

words = ["apple", "it", "python", "ai", "banana", "go", "developer", "sql"]
print(list(filter(wordlength, words)))
# ['apple', 'python', 'banana', 'developer']

# filter() + 람다함수 
words = ["apple", "it", "python", "ai", "banana", "go", "developer", "sql"]
print(list(filter(lambda word:len(word) >= 4, words)))
# ['apple', 'python', 'banana', 'developer']

# 퀴즈 - PDF 76
message = 'ab4690cfvg342가1나1다0'
for ch in message[:3]:
    print(ch.isdigit())
'''
False
False
True
'''


def filter_numstring(word):
    result_list = []
    for w in word:
        if w.isdigit():
            result_list.append(w)
    return result_list

message = 'ab4690cfvg342가1나1다0'
print(filter_numstring(message))
# ['4', '6', '9', '0', '3', '4', '2', '1', '1', '0']

# filter() + 일반함수 
def f_numstr(w):
    return w.isdigit()

message = 'ab4690cfvg342가1나1다0'
print(list(filter(f_numstr, message)))
# ['4', '6', '9', '0', '3', '4', '2', '1', '1', '0']

# filter() + 람다
print(list(filter(lambda w:w.isdigit(), message)))
# ['4', '6', '9', '0', '3', '4', '2', '1', '1', '0']


# map(함수 | 람다식 , 리스트|튜플|문자열) => map 객체 => 리스트화 나 반복문

# 세제곱한 리스트로 새로 생성 
# 일반 함수 스타일 
def make_numlist(numlist):
    result_list = []
    for num in numlist:
        result_list.append(num**3)
    return result_list

numlist = [1, 2, 3, 4, 5]
print(make_numlist(numlist))
# [1, 8, 27, 64, 125]

# map() + 일반함수 
def make_number(num):
    return num**3

numlist = [1, 2, 3, 4, 5]
print(map(make_number, numlist)) # <map object at 0x00000126D74C21C0>
print(list(map(make_number, numlist))) # [1, 8, 27, 64, 125]

# map() + 람다 
numlist = [1, 2, 3, 4, 5]
print(list(map(lambda num:num**3, numlist)))
# [1, 8, 27, 64, 125]



# 서로 다른 리스트에서 같은 위치의 데이타의 곱으로 새로운 리스트 생성 
# map() + 일반함수 
def make_multy(x, y):
    return x*y

list1 = [2,3,7]
list2 = [4,5,9]
print(list(map(make_multy, list1, list2)))
# [8, 15, 63]
# print(list1*list2) # Type Error
print(list1*3) # [2, 3, 7, 2, 3, 7, 2, 3, 7]


# map() + 람다식 
print(list(map(lambda x,y : x*y, list1, list2)))


# PDF 80

# map() + 람다식 

num_list = [100, 200, 300, 400]
name_list = ['길동', '동미', '미영', '영철']
gender_list = ['남','여','여','남']
address_list = ['서울','대전','부산','대구']

print(list(map(lambda num, name, gender, address: f"{num}-{name}-{gender}-{address}", num_list, name_list, gender_list, address_list)))
'''
['100-길동-남-서울', '200-동미-여-대전', '300-미영-여-부산', '400-영철-남-대구']
'''