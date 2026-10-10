year = int(input("구하고자는 연도 입력:"))

if (year % 4 == 0):
    print("1")
    if (year % 100 != 0) or (year % 400 == 0):
        print("윤년이네요")
else:
    print("윤년이 아니네요")

"""
윤년 == 4의 배수인 해이며, 100의 배수가 아닌 해이며, 400의 배수인 해
"""
