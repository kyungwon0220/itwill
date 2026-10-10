# readlines() 를 이용한 읽기 테스트
print('='*30)
f4 = open('data/national_anthem.txt', 'r')
data_list = f4.readlines()
print(type(data_list), len(data_list))
# <class 'list'> 20
print(data_list)
print()
for data in data_list:
    print(data, end='')
f4.close()

# with 문을 이용한 파일처리 
'''
with open(파일경로, 접근모드(r|w|a), encoding='utf-8|euc-kr|cp949') as 파일변수:
    파일변수.함수(옵션)

write()
writelines()
read()
readline()
readlines()
'''
print('='*30)
with open('data/national_anthem.txt', 'r') as file1:
    txt_list = file1.readlines()
    for txt in txt_list[:5]:
        print(txt)
print()

print('='*30)
with open('output/test3.txt', 'a') as file2:
    mylist = [10, 50, 80, 90, 100]
    for data in mylist:
        file2.write(str(data) + '\n')
print('파일쓰기 완료')

# PDF 56 
# 파일쓰기 함수 정의 - 인자 3개
def inputWriteFile(n, fileUrl, option):
    # 단어 리스트 생성 
    word_list = []
    for _ in range(n):
       word_list.append(input('단어를 입력하세요 ... ').strip()) 

    print(f"입력된 단어 리스트는 {word_list} 입니다.")
    print(f"{n} 개의 단어가 모두 저장되었습니다.")

    # 파일 쓰기 
    with open(fileUrl, 'w', encoding=option) as file:
        for word in word_list:
            file.write(word + '\n')
    
# 함수 호출
# inputWriteFile(5, 'output/output1.txt', 'utf-8')

'''
단어를 입력하세요 ... 흥부놀부
단어를 입력하세요 ... 콩쥐팥쥐
단어를 입력하세요 ... 신데렐라
단어를 입력하세요 ... 장화홍련
단어를 입력하세요 ... 피노키오 
입력된 단어 리스트는 ['흥부놀부', '콩쥐팥쥐', '신데렐라', '장화홍련', '피노키오'] 입니다.
5 개의 단어가 모두 저장되었습니다.
'''


# PDF 53
# 함수 정의 => 파일경로, 인코딩옵션, 단어 
def fileread(fileUrl, option, word):
    # 파일 읽기 후 단위 단위로 리스트화 
    with open(fileUrl, 'r', encoding=option) as file:
        data = file.read()
        data_list = data.split()

        # 특정 단어가 포함된 리스트 생성 
        result_list = []
        for data in data_list:
            if word in data:
                result_list.append(data) # 여기 변경됨 

        # 결과 출력 
        print(f"{word} 글자가 들어간 어구 출력")
        print(result_list)
        print(f"총 갯수는? {len(result_list)}")

# 함수 호출 
fileread('data/coding.txt', 'utf-8', '코딩') 
print()
'''
코딩 글자가 들어간 어구 출력
['코딩을', '코딩을', '코딩에', '코딩을', '코딩을', '코딩을', '코딩도', '코딩에', '코딩은', '코딩을', '코딩도', '코딩', '코딩도', '코딩을', '코딩을']
총 갯수는? 15
'''
fileread('data/color.txt', 'utf-8', '사람') 
'''
사람 글자가 들어간 어구 출력
['사람', '사람.', '사람이', '사람', '사람들과', '사람들은', '사람과도', '사람들과도', '사람이', '사람은', '사람', '투철사람이며', '사람이', '사람', '사람이라도', '사람', '사람들에게', '사람도', '사람.', '사람들을', '사람']
총 갯수는? 21
'''

