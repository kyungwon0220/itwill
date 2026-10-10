age = int(input("만 나이: "))
height = int(input("키: "))

if age >= 12:
    print("청소년 및 성인")
    if height >= 150:
        print("[일반 자유이용권]\n프리패스!")
    else:
        print("[일반 자유이용권]\n일부 고공 스릴 기구 제한")
else:
    print("어린이")
    if height >= 140:
        print("[어린이 자유이용권]\n모든 놀이기구 탑승 가능!")
    elif height >120:
        print("[어린이 자유이용권]\n보호자 동반시 탑승 가능")
    else:
        print("[어린이 자유이용권]\n유아 전용 기구만 이용 가능")