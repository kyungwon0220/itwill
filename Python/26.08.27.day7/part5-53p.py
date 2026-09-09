import sqlite3

conn = sqlite3.connect(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.27.day7\book.db")
print("DB 파일 생성")

cur = conn.cursor() # 커서 객체 생성
sql = '''CREATE TABLE IF NOT EXISTS book1 (
            id integer not null primary key autoincrement,
            title text not null,
            writer text,
            page integer,
            price integer);
''' # SQL 문
cur.execute(sql) # SQL문 실행
conn.commit() # 파일내 변경사항이 없을시 생략
print("테이블 생성 완료")

cur.execute('''INSERT INTO book1 (TITLE, WRITER) VALUES("PYTHON 기초", "김아무개")''')
conn.commit()
print("' TITLE ', ' WRITER ' 값을 가진 레코드 삽입 완료")


conn.close() # 파일 닫기