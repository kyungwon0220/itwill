# import keyword
# print (len(keyword.kwlist))


import datetime
print(datetime.datetime.now())
print(datetime.date.today())
print(datetime.time())
print("/////")




import requests, json
# print(dir(requests))

url = "https://jsonplaceholder.typicode.com/todos"
res = requests.get(url)

# with open(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\jsonplaceholder.html", 'w', encoding='ks_c_5601-1987') as file:
#     file.write(res.text)
# print("파일로 저장되었습니다. ")

user_list = json.loads(res.text)
# print(res_txt)
# print(res.encoding)
# print(type(user_list), type(user_list[0]), user_list[0])

# for k, v in user_list[-1].items():
#     print(f"{k} => {v}")

todos_list = []
for todo in user_list:
    if (todo['userId'] == 1) and (todo['completed'] == True):
        todos_list.append(todo)
for row in todos_list:
        print(row)


import csv
with open(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\todos.csv", "w+", newline="", encoding="utf-8-sig") as file:
    filed_list = list(todos_list[0])
    # print(filed_list)
    csv_data = csv.DictWriter(file, fieldnames = filed_list)
    csv_data.writeheader()
    csv_data.writerows(todos_list)

with open(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\todos.csv", "r", encoding="utf-8") as file:
    csv_reader = csv.reader(file)
    data_list = list(csv_reader)

print("csv 파일 최종 확인")
for row in data_list:
    print(row)
