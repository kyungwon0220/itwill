# 파일 읽기 
'''
txt 파일 => 파일변수 => 파이썬의 문자열 데이타 

파일변수 = open(파일경로, 'r', encoding='utf-8|euc-kr') 
변수 = 파일변수.읽기함수() 
파일변수.close()

파일 읽기와 관련된 함수 
read() : 전체 읽기 => 문자열 데이타
readline() : 첫행만 => 문자열 데이타
readlines() : 리스트 형태 => 문자열 데이타 리스트 
'''
f = open('data/Yesterday.txt', 'r')
txt = f.read()
print(len(txt))
# print(txt[:20])
# print(txt)

# 문자열 리스트화 (단어 단위로 리스트화)
txt_list = txt.split()
print(len(txt_list))
print(txt_list)
print()
# 문자열 리스트화 (행 단위로 리스트화)
txt_list2 = txt.split('\n')
print(len(txt_list2))
print(txt_list2)
f.close()

print('='*30)
f2 = open('data/coding.txt', 'r', encoding='utf-8')
# 첫번째 행만 출력 
# txt_line = f2.readline()
# print(txt_line)

# 반복문 + readline()
for i in range(1,6):
    txt_line = f2.readline()
    print(f"{i}행 : {txt_line}", end="")
f2.close()

'''
1행 : 코딩을 잘하는 사람의 특징
2행 : 출처 : https://coding-factory.tistory.com/464
3행 : 
4행 : 
5행 : 세상에는 코딩을 잘하는 사람들이 참 많다.그중에서는 얼마 배우지도 않았는데 이해력이 남들보다 훨씬 빠른 사람들, 흔히들 코딩에 재능이 있다고 하는 사람들도 있다.
'''

print('='*30)
# 문서 전체 읽기
f3 = open('data/coding.txt', 'r', encoding='utf-8')
while True:
    row = f3.readline()
    if row:
        print(row, end='')
    else:
        print('파일 읽기가 종료되었습니다.')
        break
f3.close()

