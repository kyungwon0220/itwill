# PDF 58 - 메서드 오버라이딩 퀴즈 
'''
Shape(부모) => shape_name , show_info(), area()
Rectangle(Shape) => 가로(width), 세로(height) , shape_name , show_info(), area()
Circle(Shape) => 반지름(radius), shape_name , show_info(), area() 
Triangle(Shape) => 밑변(base), 높이(height), shape_name , show_info(), area()
'''

import math
print(dir(math))

class Shape:
    def __init__(self, shape_name):
        self.shape_name = shape_name

    def show_info(self):
        print(f"도형 : {self.shape_name}")

    def area(self):
        pass


class Rectangle(Shape):

    def __init__(self, shape_name, width, height):
        Shape.__init__(self, shape_name)
        self.width = width
        self.height = height

    def area(self):
        return self.width*self.height

class Circle(Shape):
    def __init__(self, shape_name, radius):
            Shape.__init__(self, shape_name)
            self.radius = radius

    def area(self):
            return self.radius*self.radius*math.pi

# Triangle(Shape) => 밑변(base), 높이(height)
class Triangle(Shape):
    def __init__(self, shape_name, base, height):
        Shape.__init__(self, shape_name)
        self.base = base  
        self.height = height
    
    def area(self):
        return (self.base * self.height) / 2

# 인스턴스 리스트 생성 
shapes_list = [ Rectangle('사각형',5, 4), Circle('타원',3) , Triangle('삼각형', 5, 10) ]

for shape in shapes_list:
    shape.show_info()
    print('넓이', shape.area()) 
    print()

'''
도형 : 사각형
넓이 20

도형 : 타원
넓이 28.274333882308138

도형 : 삼각형
넓이 25.0
'''