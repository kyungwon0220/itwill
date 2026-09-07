import csv
file_path = (r"C:\Users\ITWILL\Desktop\sin\pyclass\data\wages.csv")
with open(file_path, 'r', encoding='utf-8') as f:
# DictReader 사용: 첫 행을 자동으로 키(key)로 인식
 csv_reader = csv.DictReader(f )
 data_list = list(csv_reader)

print(f" {'='*50}\n{csv_reader.fieldnames}")
print('='*50)

count = 0
for row in data_list:
 if row['race'] == "hispanic" and row['sex'] == "female" and int(row['age']) <= int(30):
     print(row['earn'], row['height'], row['sex'], row['race'], row['ed'], row['age'])
     count += 1
print( f"총 출력 : {count} 줄(개). ")
