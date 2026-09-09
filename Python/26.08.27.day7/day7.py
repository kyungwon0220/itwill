# # 44p 소멸자
# class Cat:
#     def __init__(self, kind, name, age, gender, animal_kind):
#             self.kind = kind
#             self.name = name
#             self.age = age
#             self. gender = gender
#             self. animal_kind = animal_kind
    
#     def __del__(self):
#         print("소멸자 호출")


# cat1 = Cat("코캣", "덩치", 1, "남", "고양이")
# del cat1




# # 48p 상속
# # 부모 클래스
# class Car():
#     def __init__(self, door):
#         self.speed = 0
#         self.door = door
#     def upSpeed(self, speed):
#         self.speed += speed
#         print()
#         print(f"현재 속도 : {self.speed}")
#     def printInfo(self):
#         print(f"door : {self.door}")
#         print(f"현재 속도 : {self.speed}")

# # 자식 클래스
# class Sedan(Car):
#     def __init__(self, speed, door, brand):
#         # 부모 클래스의 생성자 메서드 호출
#         Car.__init__(self, door)
#         self.speed = speed
#         self.brand = brand
    
#     # 자식 클래스에서 추가한 메서드
#     def downSpeed(self, speed):
#         self.speed -= speed
#         print(f"현재속도(자식 클래스) : {self.speed}")

#     # 메서드 오버라이딩
#     def printInfo(self):
#             print("= Sedan Print =")
#             print(f"door : {self.door}")
#             print(f"현재 속도 : {self.speed}")
#             print(f'brand : {self.brand}\n=\n')


# car1 = Car(4)
# car1.printInfo()

# car1.upSpeed(50)
# car1.printInfo()

# sedan1 = Sedan(100, 2, "H")
# sedan1.printInfo()

# sedan1.downSpeed(20)
# sedan1.printInfo()
# sedan1.upSpeed(40)
# sedan1.printInfo()




# # 49p 다중 상속
# class Papa:
#     firstName = '김'

#     def info1(self):
#         print('아파트, 차')

# class Mama:
#     familyName = '이'

#     def info2(self):
#         print('오피스텔')

# # 자식 클래스 정의
# class Child(Papa, Mama):
#     def __init__(self, myname):
#         Papa.__init__(self)
#         Mama.__init__(self)
#         self.myname = myname

#     def info3(self):
#         print('골프 회원권')

# c1 = Child("철수")
# c1.info1()
# c1.info2()
# c1.info3()




# sqlite3
import sqlite3

conn = sqlite3.connect(r"C:\Users\ITWILL\Desktop\sin\pyclass\data\test.db")
print("DB < - > File Connect!")
print(conn)

cur = conn.cursor()
print("커서 변수 생성")
print(cur)

sql = "SELECT CustomerId, FirstName, email FROM customers LIMIT 20;"
cur.execute(sql)
# data_list1 = cur.fetchall() # 리스트 안의 튜플 형태
data_list2 = cur.fetchmany(2)
print(data_list2, "\n\n", len(data_list2), "\n\n", data_list2[0])

conn.close() # 파일 닫기