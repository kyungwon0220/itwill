class Bread:
    def __init__(self, name, price, kal, src, brand):
        self.name = name
        self.price = price
        self.kal = kal
        self.src = src
        self.brand = brand

    def printAll(self):
        print("종류 : ", self.name)
        print("가격 : ", self.price)
        print("칼로리: ", self.kal)
        print("재료 : ", self.src)
        print("브랜드: ", self.brand)

    def order(self, n):
        print(self.name, " 를(을) ", n, " 개 주문.")
        print("주문 가격 : ", self.price, " * ", n, " = ", self.price*n )
