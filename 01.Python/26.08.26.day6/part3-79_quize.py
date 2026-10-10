# import keyword
# print (len(keyword.kwlist))


import datetime
print(datetime.datetime.now())
print(datetime.date.today())
print(datetime.time())
print("/////")

import csv

def makeUserData(fileurl, header_list):
    print("CSV 파일에 저장할 데이터를 입력하세요.")
    name = input("이름: ")
    age = input("나이: ")
    job = input("직업: ")

    with open(fileurl, 'a+', encoding='utf-8', newline="") as file:
        csv_data = csv.DictWriter(file, fieldnames = header_list)
        file.seek(0) # 파일 위치를 처음으로 이동
        reader = csv.reader(file) # 읽는 객체 생성
        headerChecker = next(reader, None) # 첫줄 row
        print("###test ' headerChecker = next(reader, None) ' : ", headerChecker)

        if headerChecker != header_list: # 헤더가 다르거나 없을시
            csv_data = csv.DictWriter(file, fieldnames = header_list)
            csv_data.writeheader() # ' header_list '

        csv_data.writerow({header_list[0]:name, header_list[1]:age, header_list[2]:job})
        print("저장되었습니다")




while True:
    makeUserData('./26.08.26.day6/address1.csv',["Name", "Age", "Job"])

    Re = input("더 입력? (y/n)")
    if Re == "n" or Re == "N":
        print("종료")
        break;
