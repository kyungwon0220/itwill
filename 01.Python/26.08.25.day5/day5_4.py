# 파일 입출력 
# 작업폴더에 data 폴더가 있는지 확인 
# data => csv, txt, db 파일 존재
# output 폴더 새로 생성 
'''
파일변수 = open(파일경로, 접근모드(r|w|a), encoding='utf-8|euc-kr') 
파일변수.함수(옵션)
파일변수.close()

파일쓰기와 관련된 함수 
write(문자열데이타)
writelines(문자열데이타리스트)
'''

# 파일쓰기 : 파이썬의 문자열데이타 => txt 파일로 저장 
# 파일 변수 정의 
f = open("output/test1.txt", "w", encoding="utf-8")
print(f)
# <_io.TextIOWrapper name='output/test1.txt' mode='w' encoding='utf-8'>

# 데이타 쓰기 
f.write('안녕하세요 1\n')
f.write('안녕하세요 2\n')

# 반복문을 이용한 데이타 쓰기 
for i in range(1,6):
    f.write(f"{i}행\n")

f.write('='*30)
f.write('\n')

# 문자열 데이타 리스트 정의 
txt_list = ['사과\n', '포도\n', '바나나\n' ]
f.writelines(txt_list)


print('파일 쓰기가 완료되었습니다.')

# 자원반납 => 파일닫기
f.close()