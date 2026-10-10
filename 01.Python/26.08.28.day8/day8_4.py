# JSON
import requests
import json
import csv

# print(dir(json))

'''
# https://jsonplaceholder.typicode.com/
https://jsonplaceholder.typicode.com/users
'''

# url 자료 요청 => json 데이타 => 리스트 딕셔너리 
url = "https://jsonplaceholder.typicode.com/users"
res = requests.get(url)

# json 데이타 => 문자열
res_txt = res.text
print(type(res_txt)) # <class 'str'>
# print(res_txt) 

# json.loads(json데이타문자열변수)
# json 데이타 => 문자열 => 리스트안의 딕셔너리 
user_list = json.loads(res_txt)
print(type(user_list)) # <class 'list'>
print(type(user_list[0])) # <class 'dict'>
print(user_list[0])
'''
{'id': 1, 'name': 'Leanne Graham', 'username': 'Bret', 
'email': 'Sincere@april.biz',
 'address': {'street': 'Kulas Light', 'suite': 'Apt. 556', 'city': 'Gwenborough', 'zipcode': '92998-3874', 'geo': {'lat': '-37.3159', 'lng': '81.1496'}}, 'phone': '1-770-736-8031 x56442', 'website': 'hildegard.org', 'company': {'name': 'Romaguera-Crona', 'catchPhrase': 'Multi-layered client-server neural-net', 'bs': 'harness real-time e-markets'}}
'''

for k, v in user_list[-1].items():
    print(f"{k} => {v}")
'''
id => 10
name => Clementina DuBuque
username => Moriah.Stanton
email => Rey.Padberg@karina.biz
address => {'street': 'Kattie Turnpike', 'suite': 'Suite 198', 'city': 'Lebsackbury', 'zipcode': '31428-2261', 'geo': {'lat': '-38.2386', 'lng': '57.2232'}}
phone => 024-648-3804
website => ambrose.net
company => {'name': 'Hoeger LLC', 'catchPhrase': 'Centralized empowering task-force', 'bs': 'target end-to-end models'}
'''

# 주소와 관련된 키와 값 출력 
print()
for k, v in user_list[-1]['address'].items():
    print(f"{k} => {v}")

'''
street => Kattie Turnpike
suite => Suite 198
city => Lebsackbury
zipcode => 31428-2261
geo => {'lat': '-38.2386', 'lng': '57.2232'}
'''

# todos 데이타에서 userId 키가 1이고 completed 키값이 True 인 목록 표시
url = "https://jsonplaceholder.typicode.com/todos"
res = requests.get(url)
todos_list = json.loads(res.text)
print(len(todos_list))
print(todos_list[50])
# {'userId': 3, 'id': 51, 'title': 'distinctio exercitationem ab doloribus', 'completed': False}

todos_list2 = []
for todo in todos_list:
    if (todo['userId'] == 1) and (todo['completed'] == True):
        todos_list2.append(todo)

for todo in todos_list2:
    print(todo)

print(res.encoding)

# 리스트안의 셔너리 => CSV
with open('output/todos.csv', 'w', newline='', encoding='utf-8') as file:
    field_list = list(todos_list2[0])
    print(field_list) # ['userId', 'id', 'title', 'completed']
    csv_data = csv.DictWriter(file, fieldnames=field_list)
    csv_data.writeheader()
    csv_data.writerows(todos_list2)
    print("csv 파일이 저장되었습니다")

# PDF 12
print()
url = "https://jsonplaceholder.typicode.com/users"
res = requests.get(url)
users = json.loads(res.text)
print(users[0])
'''
{'id': 1, 'name': 'Leanne Graham', 'username': 'Bret', 'email': 'Sincere@april.biz', 
'address': {'street': 'Kulas Light', 'suite': 'Apt. 556', 'city': 'Gwenborough', 'zipcode': '92998-3874', 'geo': {'lat': '-37.3159', 'lng': '81.1496'}}, 
'phone': '1-770-736-8031 x56442', 'website': 'hildegard.org', 
'company': {'name': 'Romaguera-Crona', 'catchPhrase': 'Multi-layered client-server neural-net', 'bs': 'harness real-time e-markets'}}
'''

# id, city, phone만 출력하여라
print()
print("\t id \t city \t\t\t phone")
for user in users:
    print(f"\t {user['id']} \t{user['address']['city']} \t{user['phone']} ")

# phone 이 '210.067.6132'인 회원은 누구인가?
for user in users:
    if user['phone'] == '210.067.6132':
        print(f"id => {user['id']} \t\t name => {user['name']}")
    