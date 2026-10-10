with open(r"C:\Users\ITWILL\Desktop\sin\pyclass\26.08.25.day5\test1.txt", 'a+', encoding='utf-8') as f:
    # cnt = 0

    f.seek(0)

    lines = f.readlines()
    next_line_num = len(lines) + 1

    if lines and not lines[-1].endswith('\n'): # 마지막 줄내림이 되어있는지
        f.write('\n')
    f.write(f"test {next_line_num}\n")

    f.seek(0)
    print(f.read(), end="")

'''
txt 파일 내용을 유지하며,
문자열을 추가하고,
마지막에 현재 행의 번호를 출력
(비어있는 줄내림시, 행번호 안맞는 이슈 해결)
'''
