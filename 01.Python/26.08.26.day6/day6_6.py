# 모듈 임포트 1
import student
print(dir(student))

# 인스턴스화 
s1 = student.Student('윤이서','빅데이타학과', 4)
s1.show_info()
'''
이름 : 윤이서
학과 : 빅데이타학과
학년 : 4학년
'''

# 모듈 임포트 2
from student import Student

# 인스턴스화 
s2 = Student('박윤희','AI데이타학과', 2)
s2.show_info()
'''
이름 : 박윤희
학과 : AI데이타학과
학년 : 2학년
'''

# 리스트안의 인스턴스 저장 
student_list = [
    Student('이윤희','AI데이타학과', 2),
    Student('김윤희','부동산학과', 1),
    Student('김윤정','경영학과', 4)
]

student_list[0].show_info()
print()
count = 1
for student in student_list:
    print(f"{count} 번 학생 정보")
    student.show_info()
    count += 1

'''
1 번 학생 정보
이름 : 이윤희
학과 : AI데이타학과
학년 : 2학년

2 번 학생 정보
이름 : 김윤희
학과 : 부동산학과
학년 : 1학년

3 번 학생 정보
이름 : 김윤정
학과 : 경영학과
학년 : 4학년
'''