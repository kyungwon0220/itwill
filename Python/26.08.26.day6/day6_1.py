'''
외부 파일 데이타(txt, csv, excel) => 파이썬데이타
데이타베이스(sqlite, mysqlDB, oracleDB, MongDb)  => 파이썬데이타
openAPI(xml, json)  => 파이썬데이타
클라우드(Db, 구글드라이브...) => 파이썬데이타

파일IO => 파이썬의데이타(문자열, 문자열집합형자료형(리스트, 딕셔너리))
txt => 파일변수(open) => 파이썬의데이타
csv => 파일변수(open) => csv데이타변수(csv모듈) => 파이썬의데이타

# csv 관련 함수 
DictReader, DictWriter => 리스트안의 딕셔너리
reader, writer => 중첩리스트, 중첩테이블

# csv 뷰어 익스텐션 
Seamlessly Display and Edit CSVs
'''

# csv 파일 => 리스트안의 딕셔너리 
import csv
print(dir(csv))

# 파일변수 생성 
file = open('data/data.csv', 'r')
# csv데이타변수 
csv_data = csv.DictReader(file)
print(csv_data) # <csv.DictReader object at 0x0000016834CF46E0>
data_list = list(csv_data)
print(len(data_list))
print(data_list) # 리스트안의 딕셔너리( 필드명은 딕셔너리의 키로 지정)
print(data_list[0])
'''
12
[{'class': '1', 'name': 'adam', 'kor': '67', 'eng': '87', 'mat': '90', 'bio': '98'}, {'class': '1', 'name': 'andrew', 'kor': '45', 'eng': '45', 'mat': '56', 'bio': '98'}, {'class': '1', 'name': 'ben', 'kor': '95', 'eng': '59', 'mat': '96', 'bio': '88'}, {'class': '1', 'name': 'clark', 'kor': '65', 'eng': '94', 'mat': '89', 'bio': '98'}, {'class': '1', 'name': 'dan', 'kor': '45', 'eng': '65', 'mat': '78', 'bio': '98'}, {'class': '1', 'name': 'noel', 'kor': '78', 'eng': '76', 'mat': '98', 'bio': '89'}, {'class': '2', 'name': 'paul', 'kor': '87', 'eng': '67', 'mat': '65', 'bio': '56'}, {'class': '2', 'name': 'walter', 'kor': '89', 'eng': '98', 'mat': '78', 'bio': '78'}, {'class': '2', 'name': 'oscar', 'kor': '100', 'eng': '78', 'mat': '56', 'bio': '65'}, {'class': '2', 'name': 'martin', 'kor': '99', 'eng': '89', 'mat': '87', 'bio': '87'}, {'class': '2', 'name': 'hugh', 'kor': '98', 'eng': '45', 'mat': '56', 'bio': '54'}, {'class': '2', 'name': 'henry', 'kor': '65', 'eng': '89', 'mat': '87', 'bio': '78'}]
{'class': '1', 'name': 'adam', 'kor': '67', 'eng': '87', 'mat': '90', 'bio': '98'}
'''

# 필드명만 저장
# header_list = list(data_list[0])
# header_list = data_list[0].keys()
header_list = csv_data.fieldnames # 필드명
print(header_list) # ['class', 'name', 'kor', 'eng', 'mat', 'bio']

# 필드 데이타 출력 
print('\t', end='')
for item in header_list:
    print(item, end="\t")
print('tot')
print()

# 실제 데이타 출력 1 - range() 
for i in range(len(data_list)):
    tot = int(data_list[i]['kor'])+int(data_list[i]['eng'])+int(data_list[i]['mat'])+int(data_list[i]['bio'])
    print(f'{i+1}\t{data_list[i]['class']}\t{data_list[i]['name']}\t{data_list[i]['kor']}\t{data_list[i]['eng']}\t{data_list[i]['mat']}\t{data_list[i]['bio']}\t{tot}')

print('='*10)
# 필드 데이타 출력 
print('\t', end='')
for item in header_list:
    print(item, end="\t")
print('tot')
print()
# 실제 데이타 출력 2 - for .. in ...
count = 1
for row in data_list:
    print(f"{count}\t{row['class']}\t{row['name']}\t{row['kor']}\t{row['eng']}\t{row['mat']}\t{row['bio']}")
    count += 1

file.close()


# PDF 69 
# 특정 과목의 통계 확인 (과목별 리스트, 총점, 평균, 최고점, 최하점 )
# sum(), max(), min() 
with open('data/data.csv', 'r') as f:
    csv_data = csv.DictReader(f)
    data_list = list(csv_data)
    kor_list = [] # 국어 점수 리스트 생성 
    # 국어 점수만 정수형으로 변경해서 데이타 추가 
    for row in data_list:
        kor_list.append(int(row['kor']))
    # 출력 레이아웃 
    print()
    print(f'국어 점수 리스트 : {kor_list}')
    print(f'총점 : {sum(kor_list)}\t평균 : {sum(kor_list)/len(kor_list):.2f}')
    print(f'최고점 : {max(kor_list)}\t최하점 : {min(kor_list)}')

    print()
    # 국어(kor) 과목 점수를 80점 이상 받은 학생의 이름과 점수를 출력하여라.
    for row in data_list:
        kor_data = int(row['kor'])
        if kor_data >= 80:
            print(f"{row['name']} : {row['kor']} 점")



'''
국어 점수 리스트 : [67, 45, 95, 65, 45, 78, 87, 89, 100, 99, 98, 65]
총점 : 933      평균 : 77.75
최고점 : 100    최하점 : 45

ben : 95 점
paul : 87 점
walter : 89 점
oscar : 100 점
martin : 99 점
hugh : 98 점
'''

# 함수화 
def gradePrint(fileUrl, op, gradeKey, gradeData):
    with open(fileUrl, 'r', encoding=op) as f:
        csv_data = csv.DictReader(f)
        data_list = list(csv_data)
        grade_list = [] # 점수 리스트 생성 
        for row in data_list:
            grade_list.append(int(row[gradeKey]))    
        print()
        print(f'{gradeKey} 점수 리스트 : {grade_list}')
        print(f'총점 : {sum(grade_list)}\t평균 : {sum(grade_list)/len(grade_list):.2f}')
        print(f'최고점 : {max(grade_list)}\t최하점 : {min(grade_list)}')
        print()
        # 과목 점수를 ...점 이상 받은 학생의 이름과 점수를 출력하여라.
        print(f"{gradeKey} 점수가 {gradeData} 이상인 학생 목록")
        for row in data_list:
            data = int(row[gradeKey])
            if data >= gradeData:
                print(f"{row['name']} : {row[gradeKey]} 점")

# 함수 호출 
gradePrint('data/data.csv', 'utf-8', 'kor', 80)
print()
gradePrint('data/data.csv', 'utf-8', 'mat', 60)

# PDF 70 
print()
with open('data/wages.csv', 'r') as f:
    csv_data = csv.DictReader(f)
    data_list = list(csv_data)
    # 필드 데이타 출력 
    print("race\tage\ted\theight\tsex\tearn")
    # race : hispanic , sex : female, age<=30
    count = 0
    for row in data_list:
        if (row['race']=='hispanic') and (row['sex']=='female') and (int(row['age'])<=30):
            print(f"{row['race']}\t{row['age']}\t{row['ed']}\t{row['height']}\t{row['sex']}\t{row['earn']}")
            count += 1
    print(f'전체 데이타 갯수는? {count}')
