# 객체지향 프로그래밍 (OOP)
'''
속성 + 메서드 

class 클래스명():
    
    클래스변수 = 초기값 

    # 생산자 메서드 => 속성정의  
    def __init__(self, 인자... ):
        self.속성 = 인자
        ...
    
    # 일반 메서드 
    def 메서드명(self, 인자):
        명령어 
        ... 

인스턴스명 = 클래스명(값...)

'''

# 생산자(__init__()) 와 소멸자(__del__()) 테스트 
class Myclass:
    # 클래스변수 정의 
    count = 0

    # 인스턴스가 생성될때 호출 
    def __init__(self, name):
        self.name = name
        print(f'{self.name} 인스턴스가 생성되었습니다')
        Myclass.count += 1

    # 인스턴스가 삭제될때 호출 
    # del 명령어가 수행될 때 자동 호출 
    # def __del__(self):
    #     print()
    #     print('인스턴스가 소멸되었습니다')
    #     Myclass.count -= 1
    #     print(f"count = {Myclass.count} ")

    # str(), print(인스턴스) 명령시 호출 
    def __str__(self):
        return f'인스턴스 이름 : {self.name}'



m1 = Myclass('m1')
print(f"count = {Myclass.count} ")
m2 = Myclass('m2')
print(f"count = {Myclass.count} ")

'''
m1 인스턴스가 생성되었습니다
count = 1 
m2 인스턴스가 생성되었습니다
count = 2 
'''

# 인스턴스 삭제 
del m1
del m2

# print(m1)
# NameError: name 'm1' is not defined

print()
m3 = Myclass('m3')
print(m3.name)
print(m3)
print(str(m3))
'''
m3 인스턴스가 생성되었습니다
m3
인스턴스 이름 : m3
인스턴스 이름 : m3
'''

# 상속 
'''
clss 클래스명(부모클래스1, 부모클래스2...):
    명령어
'''

# 상속 테스트 
# Car(부모클래스) => Sadan(자식클래스)
# speed, door   => speed, door, brand
# upSpeed(),printInfo()  => printInfo(), upSpeed(), downSpeed()       

# 부모 클래스 정의 
class Car:
    def __init__(self, door):
        self.door = door
        self.speed = 0

    def upSpeed(self, speed):
        self.speed += speed
        print(f'현재 속도 => {self.speed}')

    def printInfo(self):
        print(f'door => {self.door}')
        print(f'speed => {self.speed}')


# 자식 클래스 정의 
class Sedan(Car):
    def __init__(self, door, speed, brand):
        Car.__init__(self, door)
        self.speed = speed
        self.brand = brand

    def downSpeed(self, speed):
        self.speed -= speed
        print(f'현재 속도 => {self.speed}')

    # 메소드 오버라이딩 
    # 부모 클래스에서 정의된 메서드를 무시하고 
    # 자식 클래스에서 다시 재정의  
    def printInfo(self):
            print()
            print(f'door => {self.door}')
            print(f'speed => {self.speed}')
            print(f'brand => {self.brand}')


car = Car(4)
car.printInfo() 
car.upSpeed(50)
car.printInfo()
'''
door => 4
speed => 0
현재 속도 => 50
door => 4
speed => 50
'''
print()

sadan = Sedan(2, 100, '현대')
sadan.upSpeed(50)
sadan.downSpeed(80)
sadan.printInfo()
'''
현재 속도 => 150
현재 속도 => 70

door => 2
speed => 70
brand => 현대

'''