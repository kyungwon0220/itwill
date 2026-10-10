import sqlite3

# 데이타베이스 파일 생성 => 커서변수 생성
conn = sqlite3.connect('output/book.db')
print("데이타베이스 파일이 새로 생성되었습니다.")
cur = conn.cursor()

# 테이블 생성 sql 수행 => DB 반영 DB연결변수.commit()
# 기존 테이블이 없다면 id, 책제목, 저자, 페이지수, 가격 필드로 새테이블 생성 
sql = '''CREATE TABLE IF NOT EXISTS book1 (
            id integer not null primary key autoincrement,
            title text not null,
            writer text,
            page integer,
            price integer);
'''
cur.execute(sql)
conn.commit()
print("테이블 파일이 새로 생성되었습니다.")


# 레코드 삽입 
sql = '''INSERT INTO book1 (title, writer, page, price)
            VALUES ('파이썬 300제','김파이', 500, 25000);
    '''
cur.execute(sql)
conn.commit()
print("레코드가 삽입되었습니다")


conn.close()