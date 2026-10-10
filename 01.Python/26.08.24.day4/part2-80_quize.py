num_list = [100, 200, 300, 400]
name_list = ['길동', '동미', '미영', '영철']
gender_list = ['남','여','여','남']
address_list = ['서울','대전','부산','대구']

# res = []
# for i in range(0, min(len(num_list),len(name_list),len(gender_list),len(address_list))):
#     res.append(f"{num_list[i]}-{name_list[i]}-{gender_list[i]}-{address_list[i]}")

# print(res)

print(list(map(lambda num, name, gender, address:f"{num}-{name}-{gender}-{address}", num_list, name_list, gender_list, address_list)))
