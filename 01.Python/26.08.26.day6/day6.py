# # part4-24_quize
# import Calculatorr as c

# x = float(input("첫: "))
# y = float(input("둘: "))

# c1 = c.Calculatorr(x, y)

# c1.printAll()




# # part4-25_quize
# import Bread as b

# bread1 = b.Bread("모카빵", int(5000), int(700), ('설탕', '버터'), 'paris')
# bread2 = b.Bread("바게트", int(3500), int(350), ('소금', '올리브'), 'tus')

# bread1.order(2)
# bread2.order(3)




# part4-28_quize
import Cat as cat

cat1 = cat.Cat("코캣", "덩치", 1, "남", "고양이")
cat2 = cat.Cat("러시안블루", "나비", 5, "여", "고양이")

cat1.printInfo()
cat2.printInfo()

cat1.run()
cat2.run()

cat1.sleep('캣타워')
cat2.sleep('캣타워')

cat1.eat('사료')
cat2.eat('사료')
