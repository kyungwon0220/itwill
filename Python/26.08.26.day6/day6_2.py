# 파이썬 데이타 => csv 파일로 저장  
'''
조건:
    파이썬 데이타(리스트안의 리스트, 리스트안의 딕셔너리)

파일변수 => open('w') => csv 데이타변수 
=> csv파일쓰기함수
DictWriter(), writer(), writerrow()
'''
import csv
print(dir(csv))

# csv 파일에 저장할 파이썬 데이타 생성 => 중첩 리스트
data_list = [   ['이름','주소','전화번호'],
                ['김영희','부산시','010-6374-90874'],
                ['홍길동','춘천시','010-5463-9403'],
                ['성은희','서울시','010-4646-9403'] ]

# 파일 변수 생성 ('w', 'a')
# newline='' => csv 파일 쓰기시 빈행 삽입 방지
file = open('output/address.csv', 'w', encoding='utf-8', newline='')
# csv 파일 쓰기 변수 생성 
csv_data = csv.writer(file)
print(csv_data)
# <_csv.writer object at 0x000002242E2FEE60>

# writerow(1차원리스트)
# writerows(2차원리스트)
# 필드 데이타 쓰기 
csv_data.writerow(data_list[0])
print('제목 필드 쓰기가 완료되었습니다')
# 실제 데이타 쓰기 
for row in data_list[1:]:
    csv_data.writerow(row)
print('데이타 행 쓰기가 완료되었습니다')
file.close()


# with문 + writerows()을 이용한 파일쓰기 
# csv 파일에 저장할 파이썬 데이타 생성 => 중첩 리스트
data_list = [   ['이름','주소','전화번호'],
                ['김영희','부산시','010-6374-90874'],
                ['홍길동','춘천시','010-5463-9403'],
                ['성은희','서울시','010-4646-9403'] ]
with open('output/address2.csv', 'w', encoding='utf-8', newline='') as f:
    csv_data = csv.writer(f)
    # 중첩 리스트 전체 쓰기 
    csv_data.writerows(data_list)
    print('address2.csv 파일쓰기가 완료되었습니다')

# Dictwriter()를 이용한 파일쓰기 
# writerows() => 데이타쓰기
# writeheader() => 필드쓰기 
# 리스트 안의 딕셔너리 스타일로 데이타 정의 
data_dict_list = [
    {'이름':'홍길동', '주소':'부산', '나이':'33'},
    {'이름':'고길동', '주소':'대구', '나이':'23'},
    {'이름':'박길동', '주소':'울산', '나이':'28'}
]
with open('output/address3.csv', 'w', encoding='utf-8', newline='') as f2:
    # 제목 필드 리스트 정의 
    header_list = ['이름', '주소', '나이']
    # csv 쓰기 변수를 딕셔너리 스타일로 정의
    csv_data = csv.DictWriter(f2, fieldnames=header_list)
    # 필드 쓰기 
    csv_data.writeheader()
    # 데이타 쓰기
    csv_data.writerows(data_dict_list)
    print('address3.csv 파일쓰기가 완료되었습니다')