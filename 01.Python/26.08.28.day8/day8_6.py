'''
01. 한국도로공사 웹사이트에서 제공중인 OPEN API 서비스 중 
[고속도로 휴게소현황]-[ 휴게소 푸드메뉴현황 조회 서비스] 를 이용하여 
고속도로 휴게소 내 음식 메뉴 정보를 파이썬의 리스트 딕셔너리 형태로 저장하여라. 

https://data.ex.co.kr/openapi/basicinfo/openApiInfoM?apiId=0502&pn=-1

# URL 요청 샘플 
https://data.ex.co.kr/openapi/restinfo/restBestfoodList?key=2710433062&type=json&numOfRows=10&pageNo=1
'''

import requests, json, csv, sqlite3

url = "https://data.ex.co.kr/openapi/restinfo/restBestfoodList?key=2710433062&type=json&numOfRows=50&pageNo=1"
res = requests.get(url)
foods = json.loads(res.text)['list']  

print(len(foods))
print(foods[0])
# 키 목록 확인 
print(list(foods[0]))
'''
['pageNo', 'numOfRows', 'stdRestCd', 
'routeCd', 'svarAddr', 'restCd', 'routeNm',
 'stdRestNm', 'lsttmAltrUser', 'lsttmAltrDttm', 
 'seq', 'foodNm', 'foodCost', 'etc', 'recommendyn', 'seasonMenu', 
'bestfoodyn', 'premiumyn', 'app', 
'foodMaterial', 'lastId', 'lastDtime']
'''

# ==============

'''
02. '서울만남(부산)휴게소'의 푸드 메뉴 목록을 아래와 같이 출력하여라 

---------------------------------
서울만남(부산)휴게소
---------------------------------
꼬치어묵우동 | 6,500원 | 추천: N | 대표: N
새우튀김우동 | 7,500원 | 추천: N | 대표: N
'''

rest_name = "서울만남(부산)휴게소"

rest_food_list = []

for food in foods:

    if food["stdRestNm"] == rest_name:
        rest_food_list.append(food)

print()
print("---------------------------------")
print(rest_name)
print("---------------------------------")

for food in rest_food_list:

    print(
        f"{food['foodNm']} | "
        f"{food['foodCost']}원 | "
        f"추천: {food['recommendyn']} | "
        f"대표: {food['bestfoodyn']}"
    )

print('\n\n')

# ===========
# 03.  '서울만남(부산)휴게소'의 푸드 메뉴 목록 중 가장 가격이 비싼 메뉴는?

if rest_food_list:

    expensive_food = max(
        rest_food_list,
        key=lambda food: int(food["foodCost"].replace(",", ""))
    )

    print()
    print("가장 가격이 비싼 메뉴")
    print("---------------------------------")

    print(
        expensive_food["foodNm"],
        "|",
        expensive_food["foodCost"] + "원"
    )

'''
가장 가격이 비싼 메뉴
---------------------------------
소고기짬뽕곱배기 | 14000원
'''

print('\n\n')

# ===========
# 04.  '서울만남(부산)휴게소'의 푸드 메뉴 목록 중 베스트푸드 목록은?
best_food_list = []

for food in rest_food_list:

    if food["bestfoodyn"] == "Y":
        best_food_list.append(food)


print()
print("베스트푸드 목록")
print("---------------------------------")

for food in best_food_list:

    print(
        food["foodNm"],
        "|",
        food["foodCost"] + "원"
    )

'''
베스트푸드 목록
---------------------------------
말죽거리소고기국밥 | 9500원
'''

print('\n\n')

# ===========
# 05. 01에서 저장한 데이타 리스트를 csv 파일로 저장하여라. 

# 저장할 필드
fieldnames = [
    "stdRestCd",
    "stdRestNm",
    "foodNm",
    "foodCost",
    "recommendyn",
    "bestfoodyn",
    "premiumyn",
    "seasonMenu",
    "etc",
    "foodMaterial"
]

with open('output/rest_food.csv', "w", newline="", encoding="utf-8-sig") as file:
    writer = csv.DictWriter(
        file,
        fieldnames=fieldnames
    )

    writer.writeheader()

    for food in foods:

        row = {}

        for field in fieldnames:
            row[field] = food.get(field, "")

        writer.writerow(row)


print("CSV 저장 완료" )
print()

# =====================
# 06. 01에서 저장한 데이타 리스트를 sqlite 데이타베이스 파일로 저장하여라. 

DB_NAME = "output/rest_food.db"
conn = sqlite3.connect(DB_NAME)
cur = conn.cursor()

sql = """
CREATE TABLE IF NOT EXISTS rest_food (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    stdRestCd TEXT,
    stdRestNm TEXT,
    foodNm TEXT,
    foodCost INTEGER,
    recommendyn TEXT,
    bestfoodyn TEXT,
    premiumyn TEXT,
    seasonMenu TEXT,
    etc TEXT,
    foodMaterial TEXT
)
"""
cur.execute(sql)
conn.commit()

insert_sql = """
INSERT INTO rest_food (
    stdRestCd,
    stdRestNm,
    foodNm,
    foodCost,
    recommendyn,
    bestfoodyn,
    premiumyn,
    seasonMenu,
    etc,
    foodMaterial
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
"""


for food in foods:
    price = food.get("foodCost", "")
    try:
        price = int(price.replace(",", ""))
    except:
        price = 0

    cur.execute(
        insert_sql,
        (
            food.get("stdRestCd", ""),
            food.get("stdRestNm", ""),
            food.get("foodNm", ""),
            price,
            food.get("recommendyn", ""),
            food.get("bestfoodyn", ""),
            food.get("premiumyn", ""),
            food.get("seasonMenu", ""),
            food.get("etc", ""),
            food.get("foodMaterial", "")
        )
    )

conn.commit()

print(f"SQLite 저장 완료 : {DB_NAME}")

conn.close()