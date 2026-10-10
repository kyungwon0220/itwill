# 클래스 선언 
# 속성 (빵이름, 가격, 칼로리, 재료, 브랜드)
class Bread:
    # 생성자 메서드 정의 
    def __init__(self, name, price, kcal, src):
        self.name = name
        self.price = price
        self.kcal = kcal
        self.src = src
        self.brand = "파리바게트 강남1호점"

    # 빵 정보를 출력하는 메서드 정의 
    def printInfo(self):
        print(f"종류 : {self.name} ")
        print(f"가격 : {self.price} ")
        print(f"칼로리 : {self.kcal} ")
        print(f"재료 : {self.src} ")
        print(f"브랜드 : {self.brand} ")

    # 주문한 빵에 대한 가격 출력 메서드 정의 
    def printOrder(self, n):
        print(f"{self.name} 을/를 {n}개 주문하셨습니다. ")
        print(f" 주문 가격은 {self.price} X {n} = {self.price * n} ")

# 인스턴스화 
bread1 = Bread('모카빵', 5000, 700, ('강력분', '설탕', '버터', '커피가루', '건포도'))
bread2 = Bread('바게트빵', 3500, 350, ('강력분', '소금', '올리브오일'))

bread1.printInfo()
print()
bread2.printInfo()
print()
bread1.printOrder(3)
print()
bread1.printOrder(5)

'''
종류 : 모카빵 
가격 : 5000 
칼로리 : 700 
재료 : ('강력분', '설탕', '버터', '커피가루', '건포도') 
브랜드 : 파리바게트 강남1호점 

종류 : 바게트빵 
가격 : 3500 
칼로리 : 350 
재료 : ('강력분', '소금', '올리브오일') 
브랜드 : 파리바게트 강남1호점 

모카빵 을/를 3개 주문하셨습니다. 
 주문 가격은 5000 X 3 = 15000 

모카빵 을/를 5개 주문하셨습니다. 
 주문 가격은 5000 X 5 = 25000 
'''

print()
# PDF 28
class Cat:
    def __init__(self, kind, name, age, gender):
        self.animal_kind = '고양이'
        self.kind = kind
        self.name = name
        self.age = age
        self.gender = gender

    def print_info(self):
        print(f'\n\n {self.animal_kind} 정보 출력 ')
        print('='*20)
        print(f' 종류 = {self.kind}')
        print(f' 이름 = {self.name}')
        print(f' 나이 = {self.age}')
        print(f' 성별 = {self.gender}')
        print()

    def run(self):
        print(f'{self.animal_kind} {self.name} 가 달린다.')

    def sleep(self, where):
        print(f'{self.animal_kind} {self.name}가 {where}에서 잔다.')

    def eat(self, food):
        print(f'{self.animal_kind} {self.name}가 {food}을(를) 먹는다.')

    def action_print(self):
        print()
        print(f'{self.animal_kind} {self.name} 의 아침 일상')
        self.eat('물')
        self.eat('사료')
        self.run()
        self.eat('간식')
        self.sleep('쇼파')
        print()

cat1 = Cat('코캣', '덩치', 1, '남')
cat2 = Cat('러시안블루', '나비', 5, '여')

cat1.print_info()
cat2.print_info()
cat1.run()
cat2.run()
cat1.sleep('캣타워')
cat2.sleep('택배 박스')
cat1.eat('사료')
cat2.eat('춥스')

cat1.action_print()
cat2.action_print()

'''
고양이 정보 출력 
====================
 종류 = 코캣
 이름 = 덩치
 나이 = 1
 성별 = 남



 고양이 정보 출력 
====================
 종류 = 러시안블루
 이름 = 나비
 나이 = 5
 성별 = 여

고양이 덩치 가 달린다.
고양이 나비 가 달린다.
고양이 덩치가 캣타워에서 잔다.
고양이 나비가 택배 박스에서 잔다.
고양이 덩치가 사료을(를) 먹는다.
고양이 나비가 춥스을(를) 먹는다.

고양이 덩치 의 아침 일상
고양이 덩치가 물을(를) 먹는다.
고양이 덩치가 사료을(를) 먹는다.
고양이 덩치 가 달린다.
고양이 덩치가 간식을(를) 먹는다.
고양이 덩치가 쇼파에서 잔다.


고양이 나비 의 아침 일상
고양이 나비가 물을(를) 먹는다.
고양이 나비가 사료을(를) 먹는다.
고양이 나비 가 달린다.
고양이 나비가 간식을(를) 먹는다.
고양이 나비가 쇼파에서 잔다.
'''

