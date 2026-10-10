import requests, json


# url = "http://jsonplaceholder.typicode.com/users"
# res = requests.get(url)
# users = json.loads(res.text)
# print(users[0], "\n\n")

# for user in users:
#     print(f"{user['id']}\t{user['address']['city']}\t{user['phone']}")

#     if user['phone'] == "210.067.6132":
#         print(f"ID : {user['id']}\tNAME : {user['name']}")




# url = "http://data.ex.co.kr/openapi/basicinfo/openApiInfoM?apild=0508" # 휴게소별 날씨 정보 https://data.ex.co.kr/openapi/basicinfo/openApiInfoM?apiId=0508&pn=-1 ( 검색 결과 포맷 : XML, JSON )
url = "https://data.ex.co.kr/openapi/restinfo/restWeatherList?key=1098728928&type=json&sdate=20260828&stdHour=13"
res = requests.get(url)
weather = json.loads(res.text)['list'] # 제공하는 데이터상 ' ['list'] ' Key 추출이 필요하여 명시
print(type(weather)) # list 
print(len(weather)) # 187
print(weather[0]['unitName'], weather[0]['sdate'], weather[0]['stdHour'], weather[0]['tempValue'], "\n\n") # 특정 추출 EX


weather082613 = []
for w in weather: # 특정 항목 리스트로 별도 저장 
  weather082613.append({'휴게소명':w['unitName'], 
                        '도로명':w['routeName'],
                        '기온':w['tempValue'],
                        '날씨상태':w['weatherContents'],
                        '습도':w['humidityValue']})  
print(len(weather082613)) # 187

for w in weather082613:
  print(w['도로명'], end=' ')

for w in weather082613:
  if w['도로명'] == '경부선': # 경부선에 위치한 휴게소의 날씨 데이터만 출력
    print(w)




# 
# import csv
# with open(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\weather.csv", 'w', newline='', encoding='utf-8') as file: # CSV 파일로 저장
#     field_list = list(weather082613[0])
#     # print(field_list)
#     csv_data = csv.DictWriter(file, fieldnames=field_list)
#     csv_data.writeheader()
#     csv_data.writerows(weather082613)
#     print("csv 파일이 저장되었습니다\n\n")


# with open(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\weather.csv", "r", encoding="utf-8") as file:
#     csv_reader = csv.reader(file)
#     data_list = list(csv_reader)  # csv 파일을 읽어와서, 리스트형태로 추출

# print("csv 파일 최종 확인")
# for row in data_list:
#     print(row)
#


import sqlite3

conn = sqlite3.connect(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.28.day8\weather.db")
cur = conn.cursor()

# 'unitName', 'routeName', 'weatherContents', 'tempValue', 'humidityValue'
sql = '''CREATE TABLE IF NOT EXISTS wetherTbl (
            id integer not null primary key autoincrement,
            unitName TEXT,
            routeName TEXT,
            weatherContents TEXT,
            tempValue REAL,
            humidityValue REAL
            );
'''
cur.execute(sql)
conn.commit()


# 레코드 삽입 
sql = '''INSERT INTO wetherTbl 
            (unitName, routeName, weatherContents, tempValue, humidityValue)
            VALUES (?, ?, ?, ?, ?)
    '''
for w in weather:
    cur.execute(sql, (w['unitName'], w['routeName'], w['weatherContents'], w['tempValue'], w['humidityValue']) )
conn.commit()
conn.close()
