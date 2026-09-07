# CSV 파일 IO
'''
csv 파일이란?
 comma-separated values

'''

# csv 파일 데이타를 처리하는 모듈 임포트 
import csv

print(dir(csv))
'''
# csv 관련 함수 
DictReader, DictWriter
reader, writer

파일변수 = open(csvFileURL, 접근모드(w|r|a), encoding='cp949|utf-8')
csv변수 = csv.CSV관련함수(파일변수)
파일변수.close()

with open(csvFileURL, 접근모드(w|r|a), encoding='cp949|utf-8') as 파일변수:
    csv변수 = csv.CSV관련함수(파일변수)

'''
# 파일 변수 
f = open('data/data.csv', 'r', encoding='utf-8')

# 파일변수 => csv데이타변수 
csv_data = csv.reader(f)
print(csv_data) # <_csv.reader object at 0x000001C760DAA200>

# csv데이타 변수 => 파이썬의 중첩 리스트로 변경 
data_list = list(csv_data)
print(data_list)
print('='*30)
header_list = data_list[0] # 제목 리스트 
item_list = data_list[1:] # 데이타 리스트 => 중첩 리스트
# 제목 리스트만 한줄로 출력 
for header in header_list:
    print(header, end='\t')
print('avg')
print()
print('='*70)
# 데이타 리스트 출력 
for class_txt,name,kor,eng,mat,bio in item_list:
    avg = (int(kor)+int(eng)+int(mat)+int(bio))/4
    if class_txt == "1":
        print(f"{class_txt}\t{name}\t{kor}\t{eng}\t{mat}\t{bio}\t{avg:.2f}")
f.close()

# with 문을 이용한 csv 파일 처리 
print()
with open('data/wages.csv', 'r', encoding='utf-8') as file:
    csv_data2 = csv.reader(file)
    wages_list = list(csv_data2)
    for row in wages_list[:10]:
        print(row)
