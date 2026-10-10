# 클래스 변수 => 인스턴스 간의 공통 변수 
# 클래스명.클래스변수, 인스턴스명.클래스변수 

class User:
    # 클래스 변수 정의 
    address = "부산"
    count = 0
    
    def __init__(self, name, major, age):
        self.name = name
        self.major = major
        self.age = age
        # 인스턴스가 생성될때 마다 1 증가 
        User.count += 1

    def show_info(self):
        print(f"이름 : {self.name}")
        print(f"학과 : {self.major}")
        print(f"나이 : {self.age}")
        print(f"지역 : {self.address}")
        print(f"지역 : {User.address}")
        print() 

user1 = User('홍길동', '수학과', 22)
user1.show_info()
print(f'사용자 카운트 = {User.count}')
user2 = User('김수영', '물리학과', 32)
user2.show_info()
print(f'사용자 카운트 = {User.count}')


# id() => 주소값 확인 함수 
print(id(User.address)) 
print(id(user1.address)) 
'''
1288455425456
1288455425456
'''

# PDF 38 

class Library:
    # 클래스 변수: 전체 도서 수와 도서 제목을 관리
    total_books = 0
    book_titles = [] # 도서 제목을 저장할 리스트

    # 생성자 메서드 프로그래밍
    def __init__(self, title, author):
        self.title = title
        self.author = author
        # 도서 추가시 1씩 증가 
        Library.total_books += 1
        # 도서 제목 리스트에 추가 
        Library.book_titles.append(title)

    # 현재 라이브러리의 전체 도서 총권수 출력 프로그래밍
    def show_total_books(self):
        print(f'현재 도서관에 있는 책의 개수: {Library.total_books}')

    # 모든 도서의 제목 출력 프로그래밍
    def show_all_titles(self):
        print()
        print('도서관에 등록된 모든 책의 제목:')
        idx = 1
        for title in Library.book_titles:
            print(f"{idx} : {title}")
            idx += 1

# 도서 추가
book1 = Library("파이썬 자료구조", "김철수")
book2 = Library("알고리즘 개론", "이영희")
book3 = Library("데이터 과학 입문", "박민준")

# 현재 도서 개수 출력
book1.show_total_books()

# 모든 도서 제목 출력
book1.show_all_titles()

'''
현재 도서관에 있는 책의 개수: 3

도서관에 등록된 모든 책의 제목:
1 : 파이썬 자료구조
2 : 알고리즘 개론
3 : 데이터 과학 입문
'''