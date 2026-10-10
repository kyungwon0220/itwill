'''
# OPEN API 

고속도로 휴게소별 날씨
: http://data.ex.co.kr

키발급은?
[openAPI 활용]-[인증키 발급]

1098728928

openAPI 가이드 확인 
  휴게소별 날씨 
  https://data.ex.co.kr/openapi/basicinfo/openApiInfoM?apiId=0508&pn=-1

  
  https://data.ex.co.kr/openapi/restinfo/restWeatherList?key=1098728928&type=json&sdate=20260828&stdHour=13

'''

import requests, csv, json, sqlite3

url = "https://data.ex.co.kr/openapi/restinfo/restWeatherList?key=1098728928&type=json&sdate=20260828&stdHour=14"
res = requests.get(url)
weather = json.loads(res.text)['list']    
print(type(weather)) # list 
print(len(weather)) # 187
print()
print(weather[0])
print(weather[0]['unitName'], weather[0]['sdate'], weather[0]['stdHour'], weather[0]['tempValue'])
# 죽전휴게소 20260828 13 30.100000

# 특정 항목 리스트로 별도 저장 
# 'unitName', 'routeName', 'tempValue', 'weatherContents', 'humidityValue'
weather082613 = []
for w in weather:
  weather082613.append({'휴게소명':w['unitName'], 
                        '도로명':w['routeName'],
                        '기온':w['tempValue'],
                        '날씨상태':w['weatherContents'],
                        '습도':w['humidityValue']})  

print(len(weather082613)) # 187

print(weather082613[:5])

# 도로명 이름들 확인 
for w in weather082613:
  print(w['도로명'], end=' ')

# 경부선에 위치한 휴게소의 날씨 데이터만 출력
for w in weather082613:
  if w['도로명'] == '경부선':
    print(w)


# CSV 파일로 저장 
# 리스트안의 딕셔너리 => CSV
with open('output/weather.csv', 'w', newline='', encoding='utf-8') as file:
    field_list = list(weather082613[0])
    print(field_list) 
    csv_data = csv.DictWriter(file, fieldnames=field_list)
    csv_data.writeheader()
    csv_data.writerows(weather082613)
    print("csv 파일이 저장되었습니다")


# 퀴즈 - sqlite의 데이타베이스로 저장하기 
# 데이타베이스 파일 생성 => 테이블 생성 => 레코드 삽입 

# 데이타베이스 연결 및 테이블 생성 
conn = sqlite3.connect('output/weather.db')
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
    cur.execute(sql, (w['unitName'], w['routeName'], w['weatherContents'], w['tempValue'], w['humidityValue']
                      ) )

conn.commit()
conn.close()