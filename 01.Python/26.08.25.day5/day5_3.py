# try ... except.. else ... finally ...
'''
try:
    에러가 날 것 같은 명령어 
except 에러코드|Exception as e:
    에러 처리 명령어 
else:
    에러가 나지 않았을 때 명령어 
finally:
    무조건 실행 명령 
'''

# 두수를 나누는 함수 구현 - 인자 2개, return X
def divide_except(x, y):
    try:
        result = x/y
    except Exception as e:
        print(f"오류 발생 => {e}")
    else:
        print(f"{x} / {y} = {x/y:.2f}")
    finally:
        print('함수 호출을 종료합니다.')
        print()

divide_except(10, 4)
divide_except(10, 0)
divide_except('백', 10)

'''
10 / 4 = 2.50
함수 호출을 종료합니다.

오류 발생 => division by zero
함수 호출을 종료합니다.

오류 발생 => unsupported operand type(s) for /: 'str' and 'int'
함수 호출을 종료합니다.
'''

# PDF 42
# 함수 정의  - 인자 2개, return X
def register_user(user_email, user_age):
    print(f"\n--- [회원 등록 시도: {user_email}, {user_age}] ---")
    try:
       # 이메일 데이타의 유효성 검사
       # 문자열변수.index(특정문자)
       #  => 특정문자가 문자열변수에 없다면 오류발생 
       user_email.index('@')

       # 나이 유효성 검사 
       int(user_age) 
    except Exception as e:
        print(f'등록 실패: 입력 데이터 형식이 올바르지 않습니다. {e}')
    else:
        print(f'등록 성공! [이메일: {user_email}, 나이: {user_age}세]')   
    finally:
        print('--- [회원가입 절차 완료] ---')

# 함수 호출
register_user("dream@python.com", "25")
register_user("wrong_email.com", "30")
register_user("test@test.com", "twenty") 


'''
--- [회원 등록 시도: dream@python.com, 25] ---
등록 성공! [이메일: dream@python.com, 나이: 25세]
--- [회원가입 절차 완료] ---

--- [회원 등록 시도: wrong_email.com, 30] ---
등록 실패: 입력 데이터 형식이 올바르지 않습니다. substring not found
--- [회원가입 절차 완료] ---

--- [회원 등록 시도: test@test.com, twenty] ---
등록 실패: 입력 데이터 형식이 올바르지 않습니다. invalid literal for int() with base 10: 'twenty'
--- [회원가입 절차 완료] ---
'''