# 레코드 삽입 
"""
# 1개의 레코드만 삽입
sql = ''' insert into 테이블명
            values(값1, 값2, ....);
        '''

sql = ''' insert into 테이블명 (필드명1, 필드명2 ,....)
            values(값1, 값2, ....);
        '''

커서변수.execute(sql)
연결변수.commit()

# 여러개의 레코드 삽입 
데이타리스트명 = [ [값1, 값2, ....], [값1, 값2, ....]...]

sql = ''' insert into 테이블명 (필드명1, 필드명2 ,....)
            values(?, ?, ?...);
        '''
커서변수.executemany(sql, 데이타리스트명)
연결변수.commit()
"""

# vscode 익스텐션 => sqllite viewer 검색
'''
SQLite Viewer
Florian Klampfer
'''

import sqlite3

conn = sqlite3.connect('output/book2.db')
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


# 레코드 삽입 
sql = ''' insert into book1 (title, writer, page, price)
            values(?, ?, ?, ?);
        '''
data_list = [   ('파이썬 완전정복', '김파이', 500, 25000),
                ('오라클 완전정복', '박오라', 700, 45000),
                ('자바 완전정복', '이자바', 800, 35000),
                ('AI 완전정복', 'AI연구소', 200, 15000),
                ('클로드 완전정복', '민클로드', 1500, 35000) ]

cur.executemany(sql, data_list)
conn.commit()
print('레코드가 삽입되었습니다.')

# 데이타베이스 테이블 => 파이썬 리스트 
sql = ''' SELECT * FROM book1; '''
cur.execute(sql)
record_list = cur.fetchall()
print(record_list)

# 레코드 수정 
sql = ''' UPDATE book1 SET price=?, title=?
                WHERE id = ?   '''
cur.execute(sql, (35000, 'C++ 완전정복', 1))
conn.commit()
print('레코드가 수정되었습니다')

sql = ''' SELECT * FROM book1 WHERE id = 1; '''
cur.execute(sql)
record = cur.fetchone()
print(record)

# 레코드 삭제 
sql = "DELETE FROM book1 WHERE (id = ?) OR (writer = ?)"
cur.execute(sql, (2, '이자바'))
conn.commit()
print('레코드가 삭제되었습니다')
print()

# 전체 레코드 조회 
sql = ''' SELECT * FROM book1; '''
cur.execute(sql)
record_list = cur.fetchall()
for record in record_list:
    print(record)

conn.close()
