# 웹서버 자료 요청 
'''
urllib : 표준모듈 
requests : 외장모듈 

외장모듈설치(터미널에서 실행)
 : pip install 모듈명 

설치한 모듈 확인
 : pip list
'''
import requests
print(dir(requests))

url = "https://www.yes24.com/"
# response 변수 생성 
res = requests.get(url)
print(res) # <Response [200]>
# 문자열 데이타로 저장 
res_txt = res.text
print(res_txt)
print(res.encoding)
# 파일 저장 
with open('output/yes24.html', 'w', encoding='ks_c_5601-1987') as file:
    file.write(res_txt)
    print("파일로 저장되었습니다. ")