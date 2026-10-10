class Calculatorr:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def plus(self):
        return self.x + self.y
    def minus(self):
        return self.x - self.y
    def multy(self):
        return self.x * self.y
    def divide(self):
        return round(self.x / self.y, 2)

    def printAll(self):
        print("첫자: ", self.x)
        print("둘자: ", self.y)
        print("*" * 5)
        print("더하기 : ", self.plus())
        print("빼  기 : ", self.minus())
        print("곱하기 : ", self.multy())
        print("나누기 : ", self.divide())
