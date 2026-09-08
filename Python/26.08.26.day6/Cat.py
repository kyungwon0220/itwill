class Cat:
    def __init__(self, kind, name, age, gender, animal_kind):
        self.kind = kind
        self.name = name
        self.age = age
        self. gender = gender
        self. animal_kind = animal_kind

    def printInfo(self):
        print(f"종류 : {self.kind}\n이름 : {self.name}\n나이 : {self.age}\n성별 : {self.gender}\n")

    def run(self):
        print(f"{self.animal_kind} {self.name} 가 달린다.")

    def sleep(self, where):
        print(f"{self.animal_kind} {self.name} 가 {where} 에서 잔다.")

    def eat(self, what):
        print(f"{self.animal_kind} {self.name} 가 {what} 을(를) 먹는다.")

    def __del__(self):
        print("소멸자 호출")