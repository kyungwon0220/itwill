# PDF 64 - 주소록 CRUD

import sqlite3

# 데이타베이스 연결 및 테이블 생성 
conn = sqlite3.connect('output/address.db')
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

# 작동 함수들 정의 
def insert_record():
    print("\n  레코드 삽입")
    name = input("이름 : ").strip()
    mobile = input("핸드폰 : ").strip()
    email = input("이메일 : ").strip()
    addr = input("주소 : ").strip()

    sql = ''' insert into addressTbl (name, mobile, email, addr)
                values(?, ?, ?, ?);
            '''
    cur.execute(sql, (name, mobile, email, addr))
    conn.commit()


def print_record():
    sql = "SELECT * FROM addressTbl"
    cur.execute(sql)
    record_list = cur.fetchall()
    if len(record_list) == 0:
        print("등록된 주소 목록이 없습니다.")
    else:
        print(" 번호  이름  핸드폰  이메일   주소")
        print('='*30)
        for (num, name, mobile, email, addr) in record_list:
            print(f"{num} {name} {mobile} {email} {addr}")
        print()



def update_record():
    print()
    while 1:
        num = input("수정할 코드(주소록 번호)를 입력하세요").strip()
        code = input("수정할 메뉴(필드)를 입력하세요(1.이름  2.핸드폰  3.이메일   4.주소)").strip()
        if code == "1":
            data = input("이름 : ").strip()
            sql = "UPDATE addressTbl SET name=? WHERE id=?"
            cur.execute(sql, (data, num))
            break
        elif code == "2":
            data = input("핸드폰 : ").strip()
            sql = "UPDATE addressTbl SET mobile=? WHERE id=?"
            cur.execute(sql, (data, num))
            break
        elif code == "3":
            data = input("이메일 : ").strip()
            sql = "UPDATE addressTbl SET email=? WHERE id=?"
            cur.execute(sql, (data, num))
            break
        elif code == "4":
            data = input("주소 : ").strip()
            sql = "UPDATE addressTbl SET addr=? WHERE id=?"
            cur.execute(sql, (data, num))
            break       
        else:
            print("잘못 입력하셨습니다.")             



def delete_record():
    num = input("삭제할 코드(주소록 번호)를 입력하세요").strip()
    sql = "DELETE FROM addressTbl WHERE id = ?"
    cur.execute(sql, (num,))
    conn.commit()
    print("해당 레코드를 삭제했습니다... ")



def delete_all_record():
    sql = "DELETE FROM addressTbl"
    cur.execute(sql)
    conn.commit()
    print("레코드가 모두 삭제되었습니다.")

# 메인 함수 정의 
while True:
   print("="*50)
   print("    주소록") 
   print("="*50) 
   print(" 1. 연락처 입력 ")
   print(" 2. 연락처 출력 ")
   print(" 3. 연락처 수정 ")
   print(" 4. 연락처 삭제 ")
   print(" 5. 연락처 초기화 ")
   print(" 6. 종료 ")
   print("="*50) 

   menu = input("메뉴 선택: ").strip() 
   if menu == "1" : insert_record()
   elif menu == "2" : print_record()
   elif menu == "3" : update_record()
   elif menu == "4" : delete_record()
   elif menu == "5" : delete_all_record()
   elif menu == "6" : 
       print("프로그램 종료")
       break
   else:
       print("잘못된 입력입니다. 다시 입력하세요")

conn.close()