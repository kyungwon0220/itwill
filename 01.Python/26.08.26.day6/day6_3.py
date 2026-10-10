# PDF 78
import csv

def makeUserData(fileurl, op):
    # 1) 파일 변수 생성 => csv 파일 생성 => 필드 쓰기 
    header_list = ['이름', '나이', '직업']
    with open(fileurl, 'a', encoding=op, newline='') as file:
        csv_data = csv.DictWriter(file, fieldnames=header_list)
        csv_data.writeheader()

    # 2) 사용자 입력을 받아 csv 파일에 저장 
    with open(fileurl, 'a', encoding=op, newline='') as file:
        csv_data = csv.DictWriter(file, fieldnames=header_list)
        while True:
            print('CSV 파일에 저장할 데이터를 입력하세요.')
            name = input('이름: ').strip()
            age = input('나이: ').strip()
            job = input('직업: ').strip()
            csv_data.writerow({'이름':name, '나이':age, '직업':job})
            print('데이터가 CSV 파일에 저장되었습니다!')

            # 데이타 입력 추가 여부 
            ans = input('더 입력하시겠습니까? (종료시 n): ').strip().lower()
            if ans == 'n':
                print("프로그램을 종료합니다.")
                break


# 함수 호출 
makeUserData('output/quiz_data.csv', 'utf-8')