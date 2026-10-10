list1 = [2,3,7]
list2 = [4,5,9]
list3 = []

for i in range(0, len(list1) if len(list1) < len(list2) else len(list2)):
    list3.append(list1[i] * list2[i])

print(list3)
