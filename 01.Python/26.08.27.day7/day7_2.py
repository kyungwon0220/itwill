# 다중 상속 
'''
clss 클래스명(부모클래스1, 부모클래스2...):

    def __init__(self, 인자...):
        부모클래스1.__init__(self, 인자...)
        부모클래스2.__init__(self, 인자...)
        self.속성 = 인자 
        ...

    명령어
'''

# 다중상속 테스트 
# Papa, Mama(부모클래스) => Child(자식클래스)
# firstName, familyName   => firstName, familyName, myname
# info1(), info2(), addressInfo()  => info1(), info2(), addressInfo(), info3()

# 부모 클래스1 정의
class Papa:
    firstName = '김'

    def info1(self):
        print('아파트, 차')

    def addressInfo(self):
        print("주소 => 서울")

# 부모 클래스2 정의
class Mama:
    familyName = '이'

    def info2(self):
        print('오피스텔')

    def addressInfo(self):
        print("주소 => 부산")

# Papa, Mama 클래스를 상속받는 자식 클래스 정의 
# class Child(Papa, Mama):
class Child(Mama, Papa):
    def __init__(self, myname):
        Papa.__init__(self)
        Mama.__init__(self)
        self.myname = myname

    def info3(self):
            print('하이닉스 주식 30주')

child1 = Child('철수')
print(child1.firstName, child1.familyName, child1.myname)
child1.info1()
child1.info2()
child1.info3()
child1.addressInfo()
'''
김 이 철수
아파트, 차
오피스텔
하이닉스 주식 30주
주소 => 부산
'''

# PDF 51
# Person, Employee(부모클래스) => Manager(자식클래스)
# (name, age), (position, salary)   => name, age, position, salary
# introduce(), work() => introduce(), work(), manage()

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def introduce(self):
        print(f"안녕하세요, 제 이름은 {self.name}이고 {self.age}살입니다.")

class Employee:
    def __init__(self, position, salary):
        self.position = position
        self.salary = salary
    def work(self):
        print(f"{self.position}로 일하고 있습니다.")

class Manager(Person, Employee):

    def __init__(self, name, age, position, salary):
        Person.__init__(self, name, age)
        Employee.__init__(self, position, salary)

    def manage(self):
        print(f"{self.name} 은/는 {self.position}로서 팀을 관리하고 있습니다.")

# 객체 생성
manager = Manager("홍길동", 35, "매니저", 5000)

# 메서드 호출 : introduce(), work(), manage()
manager.introduce()
manager.work()
manager.manage()
'''
안녕하세요, 제 이름은 홍길동이고 35살입니다.
매니저로 일하고 있습니다.
홍길동 은/는 매니저로서 팀을 관리하고 있습니다.
'''


# 상속관계에서의 메서드 오버라이딩 
# super() => 부모클래스의 메서드를 다시 호출할때 사용 
# Tiger, Lion(부모클래스) => Liger(자식클래스)
# (kind), (kind)   => kind, name
# (jump(), cry()) , (bite(), cry()) => cry(), bite()
#                                      play(), jump(), jump_papa()

# 부모 클래스 
class Tiger:
    kind = '호랑이'
    def jump(self):
        print(f'{Tiger.kind} 처럼 점프하기')
    def cry(self):
        print(f'{self.kind} : 어흥 ~')

class Lion:
    kind = '사자'
    def bite(self):
        print(f'{self.kind} 처럼 한입에 꿀꺽하기')
    def cry(self):
        print(f'{self.kind} : 으르렁 ~')

# 자식 클래스 
class Liger(Tiger, Lion):
    kind = '라이거'

    def __init__(self, name):
        Tiger.__init__(self)
        Lion.__init__(self)
        self.name = name

    def play(self):
        print(f'{self.kind} 처럼 사육사와 놀기')

    # 메서드 오버라이딩
    def jump(self):
        print(f'{self.kind} 처럼 달리면서 점프하기~')

    # 부모 클래스(Tiger)에 정의된 메서드를 다른 이름으로 정의 
    def jump_papa(self):
        super().jump()

liger = Liger('철순이')
print()
liger.cry() # 라이거 : 어흥 ~
liger.jump() # 라이거 처럼 달리면서 점프하기~
liger.jump_papa() # 호랑이 처럼 점프하기
liger.bite()
liger.play()
'''
라이거 처럼 한입에 꿀꺽하기
라이거 처럼 사육사와 놀기
'''