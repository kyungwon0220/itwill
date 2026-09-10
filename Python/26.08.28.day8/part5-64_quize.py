import sqlite3

# 데이타베이스 연결 및 테이블 생성 
conn = sqlite3.connect(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\address.db")
cur = conn.cursor()
sql = '''CREATE TABLE IF NOT EXISTS addressTbl (
            id integer not null primary key autoincrement,
            name text not null,
            mobile text not null,
            email text not null,
            addr text not null
            );
'''
cur.execute(sql)
conn.commit()
print("DB 파일 생성 완료")
# conn.close()

# 작동 함수들 정의 
def insert_record():
    print("\n\t연락처 입력")
    name = input("이름 : ")
    mobile = input("핸드폰 : ")
    email = input("이메일 : ")
    addr = input("주소 : ")

    sql = ''' insert into addressTbl (name, mobile, email, addr)
            values(?, ?, ?, ?);
        '''
    cur.execute(sql, (name, mobile, email, addr))
    conn.commit()
    print("연락처 입력 완료!\n\n")
    pass

def print_record():
    print("\n\t연락처 출력")
    print("\t", "-"*20)
    print("번호\t이름\t핸드폰\t이메일\t주소")
    print("\t", "_"*20)


    # 전체 레코드 조회
    sql = ''' SELECT * FROM addressTbl; '''
    cur.execute(sql)
    record_list = cur.fetchall()
    for record in record_list:
        id, name, mobile, email, addr = record
        print(f"{id}\t{name}\t{mobile}\t{email}\t{addr}")
    print("연락처 출력 완료!\n\n")
    pass

def update_record():
    print("\n\t연락처 수정")
    idNum = input("수정할 ID 입력 (INT) : ")
    num = input("수정할 항목 입력 :\n(1.이름 2.핸드폰 3.이메일 4.주소) : ")

    if num == '1' or num == 1:
        column = "name"
        value = input("새 이름 입력 : ")
    elif num == '2' or num == 2:
        column = "mobile"
        value = input("새 핸드폰 입력 : ")
    elif num == '3' or num == 3:
        column = "email"
        value = input("새 이메일 입력 : ")
    elif num == '4' or num == 4:
        column = "addr"
        value = input("새 주소 입력 : ")
    else:
        print("항목 입력 오류로, 수정없이 초기 화면으로 돌아갑니다.")
        return

    sql = f"UPDATE addressTbl SET {column} = ? WHERE id = ?"
    cur.execute(sql, (value, idNum)) # 컬럼명은 직접 문자열로 구성, 값은 ? 바인딩
    conn.commit()
    print("연락처 수정 완료!\n\n")
    pass

def delete_record():
    print("\n\t연락처 삭제")

    idNum = int(input("삭제할 ID 입력 (INT) : "))

    sql = f"DELETE FROM addressTbl WHERE ID = {idNum}"
    cur.execute(sql) # 컬럼명은 직접 문자열로 구성, 값은 ? 바인딩
    conn.commit()
    print("연락처 삭제 완료!")

    print_record()
    pass

def delete_all_record(): # 나중에 ID num 초기화 기능 추가 해보기
    check = input("\n\t정말 연락처 초기화 진행? (y/n) :")
    if check == 'y' or check == 'Y':
        sql = "DELETE FROM addressTbl"
        cur.execute(sql)
        conn.commit()
        print("레코드가 모두 삭제되었습니다.")

        print_record()
    else:
        print("초기화하지 않고, 초기 화면으로 돌아갑니다.")
    pass




menu = True
while menu:
    print("\t", "="*10)
    print("\t주소록 메뉴")
    print("\t", "="*10)
    print("\n1.\t연락처 입력\n2.\t연락처 출력\n3.\t연락처 수정\n4.\t연락처 삭제\n5.\t연락처초기화\n6.\t종료")
    print("="*10)
    menu = input("메뉴선택: ")
    if menu == '6' or menu == 6: break
    elif menu == '1' or menu == 1: insert_record()
    elif menu == '2' or menu == 2: print_record()
    elif menu == '3' or menu == 3: update_record()
    elif menu == '4' or menu == 4: delete_record()
    elif menu == '5' or menu == 5: delete_all_record()
    else: print(" 1 ~ 6 재입력 필요")


conn.close()
