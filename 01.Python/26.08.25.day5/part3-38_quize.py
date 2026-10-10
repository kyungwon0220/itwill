def make_int_list(txtlist):
    newlist = []
    for i in range(0, len(txtlist)):
        try:
            newlist.append(int(txtlist[i]))
        except:
            pass

    return newlist

numbers_list = make_int_list(["10", "20", "abc", "40"])
print(f"변환된 숫자 리스트: {numbers_list} {type(numbers_list)}\n")

numbers_list = make_int_list(["327", "파이썬", "-100", "123-890", "0", "3.14"])
print(f"변환된 숫자 리스트: {numbers_list} {type(numbers_list)}\n")
