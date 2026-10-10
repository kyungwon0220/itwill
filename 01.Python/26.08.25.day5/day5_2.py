# 오류 알아보기 
'''
문법 오류 
논리적 오류 
예외처리 가능 오류 
  => try ... except ... 문법 처리 가능오류  
'''

# NameError
# print(hello)

# ZeroDivisionError: division by zero
# print(12/0)

# IndexError: list index out of range
# mylist = [ 10, 45, 56]
# print(mylist[5])

# ValueError: invalid literal for int() with base 10: '하나'
# print(int(3.14))
# print(int('45'))
# print(int('하나'))

# '구분문자'.join(문자열|문자열리스트|문자열튜플)
# print(','.join('12345'))
# 1,2,3,4,5
# print(','.join(12345))
# TypeError: can only join an iterable


'''
예외(Exception)

try ... except 
try ... except ... else 
try ... except ... else ... finally ...

raise => 사용자정의 오류 

'''

# try ... except 에러코드 as e
'''
try:
    에러가 날것 같은 명령어 
    ...
except 에러코드1 as e:
    에러 처리 명령어 
    e 는 에러메세지 별칭 
except 에러코드2 as e:
    에러 처리 명령어 
    e 는 에러메세지 별칭 
'''


mylist = [ 10, 45, 56]
mytxt = '도레미파솔라시'

try:
    print(12/3)
    print(mylist[0])
    print(int(mytxt))
    print(mylist[10])
    print(12/0)
except ZeroDivisionError as e:
    print('ZeroDivisionError 발생', e)
except IndexError as e:
    print('IndexError 발생', e)
except ValueError as e:
    print('ValueError 발생', e)
print('예외처리 테스트 종료 ')

'''
4.0
10
ValueError 발생 invalid literal for int() with base 10: '도레미파솔라시'
예외처리 테스트 종료 
'''

# try ... except Exception as e....
'''
try:
    에러가 날것 같은 명령어 
    ...
except Exception as e:
    에러 처리 명령어 
    e 는 에러메세지 별칭 
'''

mylist = [ 10, 45, 56]
mytxt = '도레미파솔라시'
print()
try:
    print(12/3)
    print(mylist[0])
    print(int(mytxt))
    print(12/0)
    print(mylist[10])
except Exception as e:
    print(f'예외처리 에러 발생 => {e}')
print('예외처리 테스트 종료 ')


print() 
# pass 문을 이용한 try ... except 처리 
# 리스트안에서 숫자만 필터링해서 절대값 처리해서 새로운 리스트로 생성 

numList = [-42, '21', '십오', 39, -66, '구십삼', -38, 15, 18, 63]
resultList = []
for num in numList:
    try:
        resultList.append(abs(num))
    except Exception:
        pass # 에러무시 
print(numList)
print(resultList)

'''
[-42, '21', '십오', 39, -66, '구십삼', -38, 15, 18, 63]
[42, 39, 66, 38, 15, 18, 63]
'''

# try ... except ... else ...
'''
try:
    에러가 날것 같은 명령어 
    ...
except Exception as e:
    에러 처리 명령어 
    e 는 에러메세지 별칭 
else:
    에러가 발생하지 않았을 경우 명령어 
'''
print('='*20)
numList = [-42, '21', '십오', 39, -66, '구십삼', -38, 15, 18, 63]
resultList = []
for num in numList:
    try:
        data = abs(num)
    except:
        print(f'에러발생 => {num}')
    else:
        resultList.append(data)
print(numList)
print(resultList)

'''
====================
에러발생 => 21
에러발생 => 십오
에러발생 => 구십삼
[-42, '21', '십오', 39, -66, '구십삼', -38, 15, 18, 63]
[42, 39, 66, 38, 15, 18, 63]
'''

# PDF 37 
def add_except():
    try:
        x = int(input('숫자1 입력?...').strip())  
        y = int(input('숫자2 입력?...').strip())  
    except:
        print('입력 데이타가 숫자가 아닙니다.')  
    else:
        print(f"{x} + {y} = {x+y}")

add_except()
'''
숫자1 입력?...45
숫자2 입력?...ty
입력 데이타가 숫자가 아닙니다.

숫자1 입력?...45
숫자2 입력?...10
45 + 10 = 55
'''


# PDF 38 

# 함수 정의 : 입력 인자(문자리스트), 반환값(숫자리스트) return
def make_int_list(txtlist):
    result_list = []
    for txt in txtlist:
        try:
            num = int(txt)
        except:
            pass
        else:
            result_list.append(num)
    return result_list

print()
numbers_list = make_int_list(["10", "20", "abc", "40"])
print(f"변환된 숫자 리스트1 : {numbers_list} 길이: {len(numbers_list)}")

print()
numbers_list = make_int_list(["327", "파이썬", "-100", "-890", "0", "3.14"])
print(f"변환된 숫자 리스트2 : {numbers_list} 길이: {len(numbers_list)}")

'''
변환된 숫자 리스트1 : [10, 20, 40] 길이: 3

변환된 숫자 리스트2 : [327, -100, -890, 0] 길이: 4
'''

