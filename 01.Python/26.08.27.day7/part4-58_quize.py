class Shape:
    def __init__(self, shape_name = "도형"):
        self.shape_name = shape_name

    def show_info(self):
        print("도형의 이름 : ", self.shape_name)

    def area(self):
        print("도형의 넓이 : ")

class Rectangle(Shape):
    def __init__(self, width, height):
        self.shape_name = "사각형"
        Shape.__init__(self, self.shape_name)
        self.width = width
        self.height = height

    def area(self):
        return float(self.width * self.height)

class Circle(Shape):
    def __init__(self, radius):
        self.shape_name = "원"
        Shape.__init__(self, self.shape_name)
        self.radius = radius

    def area(self):
        return float(self.radius*self.radius*3.14)

shapes = [ Rectangle(5, 4), Circle(3) ]

for shape in shapes:
    shape.show_info()
    print(f"넓이 : {shape.area():.2f}")
    print("-" * 20)
