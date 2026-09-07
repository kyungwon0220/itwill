def gugu_print1(n):
    for i in range(1, 10):
        print(n, " * ", i, " = ", n*i)
    print("")


def gugu_print2():
    for i in range(1, 10):
        for j in range(1, 10):
            print(i, " * ", j, " = ", i*j)
        print("")


if __name__ == "__main__":
    print("gugu.py 구구단 출력 함수 모듈 파일")
