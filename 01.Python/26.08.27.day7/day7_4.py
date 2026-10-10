# sqlite 데이타베이스 연동 
'''
데이터베이스(DBMS)
- 관계형 => 테이블 형태, sqlite, MariaDB, MySQL, Oracle...
           SQL
- NoSQL 데이타베이스 => MongoDB, 카산드라, Redis...

관계형 데이타베이스 : 
    데이타베이스 > 테이블 > 행(원소) + 열(속성)

기본키(PK:Primary Key) 
보조키(alternate key)
외래키(FK : Foreign Key)

sqlite 
- 파일하나에 데이타베이스 하나가 할당 
- .db, .sqlite3, .sqlite
- SQL 언어 지원 
- 파이썬 표준 모듈(sqlite3) 지원됨

'''

# PDF 12
'''
설치프로그램 
- https://sqlitebrowser.org/dl/

DB Browser for SQLite - Standard installer for 64-bit Windows

아래 파일 더블 클릭 후 설치 
DB.Browser.for.SQLite-v3.13.1-win64.msi
'''

# db 파일 확인 
# data/test.db

# SQLite 브라우저에서 [데이타베이스 열기 ]

# SQLite 브라우저에서 sql 명령어 실행하기 
'''
Create => 데이타베이스 생성, 테이블 생성  (CREATE)
Read  => 조회 (SELECT)
Update => 필드 수정, 레코드 삽입 (INSERT, UPDATE) 
Delete => 레코드 별로 삭제 (DELETE, DROP)
'''

# sql 명령어 특징 
'''
대소문자를 구별하지 않는다. 
명령어 마지막에 세미콜른(;) 삽입
관계형데이타베이스에서 공통적으로 사용한다  
'''

# SELECT => 필드별 조건별 레코드 조회 
'''
SELECT *|필드명 FROM 테이블명 
    WHERE 조건절 
    ORDER BY 기준필드명 ASC|DESC
    LIMIT 레코드행숫자;

-- SQL주석문
SELECT * FROM employees LIMIT 3;

SELECT lastname, firstname FROM employees;

SELECT lastname, firstname FROM employees
    WHERE employeeid=8 OR employeeid=6;

    
SELECT *|필드명 FROM 테이블명 
    WHERE 조건절 
    ORDER BY 기준필드명 ASC|DESC
    LIMIT 레코드행숫자;

SELECT * FROM albums
    ORDER BY title ASC 
    LIMIT 10;    


    -- SQL주석문
SELECT * FROM employees;

SELECT lastname, firstname FROM employees;

SELECT lastname, firstname FROM employees
    WHERE employeeid=8 OR employeeid=6;
	
SELECT * FROM albums
    ORDER BY title DESC 
    LIMIT 10; 
	
-- LIKE %서식 
SELECT * FROM albums
	WHERE title LIKE 'a%';
	
-- LIKE _서식 
SELECT * FROM albums
	WHERE title LIKE 'w__';

-- count() : 레코드수 반환 
SELECT count(*) FROM albums;

SELECT count(*) FROM albums
	WHERE title LIKE 'a%';

''' 

# SQLite 브라우저에서 글꼴 스타일 변경은?
'''
[편집] - [환경설정]
'''

