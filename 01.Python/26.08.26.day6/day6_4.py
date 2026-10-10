# 객체지향 프로그래밍 
'''
절차지향 - C, Fortran, Cobol 
객체지향 - C++, C#, Java
          Javascript, Python, 
'''

# 속성 
# 사각형 => 가로(w), 세로(h), 색상(c)
# 타원 => 반지(r), 색상(c), 패턴(p)

# 생성자 메서드가 없는 형태 
# 사각형 클래스 선언 
class Square:
    pass

# 클래스에 의해서 만들어진 인스턴스에 값 지정 
# 인스턴스명 = 클래스명(값1, 값2...)
# 인스턴스.속성 = 값
square1 = Square()
square1.width = 10
square1.height = 5
square1.color = "빨강"
print(square1)
print(square1.width, square1.height, square1.color)
'''
<__main__.Square object at 0x0000023945BB4440>
10 5 빨강
'''

# 생성자 메서드가 있는 형태 
# 사각형 클래스 선언 
class SquareObj:
    # 생성자 메서드(__init__) 선언 
    # 첫인자가 self, 값 전달 역할 
    def __init__(self, width, height, color):
        self.width = width
        self.height = height
        self.color = color

    # 일반 메서드 정의 => 속성 출력 용도
    def printInfo(self):
        print(f'가로 크기 => {self.width}')
        print(f'세로 크기 => {self.height}')
        print(f'색상 => {self.color}')

    # 사각형의 넓이를 출력하는 메서드 정의 
    # 별도 인자가 있는 경우 
    def printArea(self, mark):
        print(f'사각형의 넓이 {mark} {self.width * self.height}')


# 사각형 인스턴스 생성 
s1 = SquareObj(10, 20, '파랑')
s2 = SquareObj(5, 5, '오렌지')
print(s1.width, s1.height, s1.color)
print(s2.width, s2.height, s2.color)
print('='*20)
# 일반 메서드 호출 
# 인스턴스명.메서드명(값...)
s1.printInfo()
s1.printArea(':')
print('='*10)
s2.printInfo()
s2.printArea('==>')

# ==========
# PDF 24
class Calculator:
    # 생성자 메서드 정의 (x, y)
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.made = "korea" # 초기값 지정 

    # 계산기 메서드 정의 : 반환값 O
    def plus(self):
        return self.x + self.y
    
    def minus(self):
            return self.x - self.y
    
    def multy(self):
            return self.x * self.y
    
    def divide(self):
            return round(self.x / self.y, 2)


    # 사칙연산 출력 메서드 
    def printResult(self):
         print(f'더하기 : {self.plus()}')
         print(f'빼기 : {self.minus()}')
         print(f'곱하기 : {self.multy()}')
         print(f'나누기 : {self.divide()}')

# 인스턴스화 
c1 = Calculator(10, 3)
print(c1.divide())
c1.printResult()
print('='*10)
c2 = Calculator(50, 6)
print(c2.divide())
c2.printResult()
'''
3.33
더하기 : 13
빼기 : 7
곱하기 : 30
나누기 : 3.33
==========
8.33
더하기 : 56
빼기 : 44
곱하기 : 300
나누기 : 8.33
'''