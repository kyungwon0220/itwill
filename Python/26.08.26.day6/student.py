# student.py
# 수강생 클래스 선언 
class Student:
    def __init__(self, name, major, grade):
        self.name = name
        self.major = major
        self.grade = grade

    def show_info(self):
        print(f"이름 : {self.name}")
        print(f"학과 : {self.major}")
        print(f"학년 : {self.grade}학년")
        print()


if __name__ == '__main__':
    print("student.py 파일에서 실행중입니다.")
    student = Student('김철','컴퓨터 공학과', 1)
    student.show_info()
    '''
    student.py 파일에서 실행중입니다.
    이름 : 김철
    학과 : 컴퓨터 공학과
    학년 : 1학년
    '''