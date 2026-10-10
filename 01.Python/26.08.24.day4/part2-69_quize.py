f2 = lambda *args:print(sum(args), ",\t", f"{(sum(args)/len(args)):.3f}")

f2(100, 80, 90)
f2(77, 75, 56)
