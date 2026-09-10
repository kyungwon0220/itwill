# csv I/O 최종 EX CODE
import sqlite3

conn = sqlite3.connect(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\book2.db")
print("데이타베이스 파일이 새로 생성되었습니다.")
cur = conn.cursor()
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



# 여러 레코드 삽입
sql = ''' insert into book1 (title, writer, page, price)
            values(?, ?, ?, ?);
        '''
data_list = [ ('해리포터1', '조앤 K. 롤링', 500, 25000),
                ('파이썬 완전정복', '김파이', 7, 45000),
                ('해리포터2', 'K. 롤', 5, 250),
                ('오라클 완전정복', '박오라', 70, 4500),
                ('해리포터3', '조앤. 링', 50, 2500)
            ]
cur.executemany(sql, data_list)
conn.commit()




sql = ''' SELECT * FROM book1; '''
cur.execute(sql)
record_list = cur.fetchall()
print(record_list, "\n\n")




sql = ''' SELECT * FROM book1 WHERE id = 1; '''
cur.execute(sql)
record = cur.fetchone()
print(record)


sql = ''' UPDATE book1 SET price=?, title=?
                WHERE id = ?   '''
cur.execute(sql, (35000, 'C++ 완전정복', 1))
conn.commit()
print('레코드가 수정되었습니다')


sql = ''' SELECT * FROM book1 WHERE id = 1; '''
cur.execute(sql)
record = cur.fetchone()
print(record)


sql = "DELETE FROM book1 WHERE (id = ?) OR (writer = ?)"
cur.execute(sql, (1, '조앤 K. 롤링'))
conn.commit()
print('레코드가 삭제되었습니다\n\n\n')


# 전체 레코드 조회
sql = ''' SELECT * FROM book1; '''
cur.execute(sql)
record_list = cur.fetchall()
for record in record_list:
    print(record)
