# sqlite 데이타베이스안의 테이블 => 파이썬의 데이타 
'''
관련 모듈 => sqlite3

DB접속(connect()) => 커서 객체(cursor()) 
    => sql 명령수행(select * from 테이블명) => 중첩 튜플 구조의 데이타

'''

# 관련 모듈 임포트 
import sqlite3
# print(dir(sqlite3))

# DB접속(connect())
# DB접속변수 = sqlite3.connect(데이타베이스파일경로)
# 파일이 있다면 연결. 파일이 없다면 데이타베이스 파일 생성 
conn = sqlite3.connect('data/test.db')
print("데이타베이스 파일이 연결되었습니다.")
print(conn)
# <sqlite3.Connection object at 0x000002CF3664F5B0>

# 커서변수 생성 
# 커서변수명 = DB접속변수.cursor()
cur = conn.cursor()
print("커서 변수가 생성되었습니다.")
print(cur)
# <sqlite3.Cursor object at 0x00000253CD5EBCC0>

# sql명령을 수행해서 파이썬 데이타에 저장
# 커서변수명.excute(sql명령어문자열)
# 데이타변수 = 커서변수명.함수() => fetchall(), fetchone(), fetchmany(n)
sql = "SELECT * FROM customers LIMIT 20;"
cur.execute(sql)
data_list = cur.fetchall()
print(data_list) # 리스트안의 튜플 
print(len(data_list)) # 20
print(data_list[0]) # (1, 'Luís', 'Gonçalves', 'Embraer - Empresa Brasileira de Aeronáutica S.A.', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', '+55 (12) 3923-5555', '+55 (12) 3923-5566', 'luisg@embraer.com.br', 3)

print('='*20)
sql = '''SELECT CustomerId, FirstName, email
	            FROM customers; '''
cur.execute(sql)
data_list2 = cur.fetchmany(10)
print(len(data_list2))
for (CustomerId, FirstName, email) in data_list2:
    print(CustomerId, FirstName, email)
'''
1 Luís luisg@embraer.com.br
2 Leonie leonekohler@surfeu.de
3 François ftremblay@gmail.com
4 Bjørn bjorn.hansen@yahoo.no
5 František frantisekw@jetbrains.com
6 Helena hholy@gmail.com
7 Astrid astrid.gruber@apple.at
8 Daan daan_peeters@apple.be
9 Kara kara.nielsen@jubii.dk
10 Eduardo eduardo@woodstock.com.br
'''
# 파일 닫기 
conn.close()