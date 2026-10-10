h = int(input("키: "))
w = int(input("체중:"))

bmi = round(w/(h*h/10000), 2) # cm > m 단위 변환을 위해서 ( * 10,000 )

print("BMI : ", bmi)


if bmi > 35:
    print("고도 비만")
elif bmi >= 30:
    print("중증도 비만")
elif bmi >= 25:
    print("경도 비만")
elif bmi >= 23:
    print("과체중")
elif bmi >= 18.5:
    print("정상")
else:
    print("저체중")
