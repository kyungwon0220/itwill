# 파일 내용 추가하기 
# 'a' 이면 파일이 없다면 새로 생성. 있다면 내용이 추가 
f = open('output/test2.txt', 'a', encoding='utf-8')
print('파일이 생성되었습니다.')
f.write('\n파일 쓰기 시작2')
f.write('='*30)
f.write('\n')
f.close()