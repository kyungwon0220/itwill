# 모듈 불러오기 
'''
import 모듈명
모듈명.함수(옵션)

import 모듈명 as 별칭
별칭명.함수(옵션)

from 모듈명 import 함수명
함수(옵션)
'''

# math => 수학함수 전용 모듈, 표준모듈 
import math

# 모듈 가이드
# help(math)

print(math.__doc__)
print()
# 모듈제공함수 => 문자열리스트 
print(dir(math))
'''
['__doc__', '__loader__', '__name__', '__package__', '__spec__', 'acos', 'acosh', 
'asin', 'asinh', 'atan', 'atan2', 'atanh', 'cbrt', 'ceil', 'comb', 
'copysign', 'cos', 'cosh', 'degrees', 'dist', 'e', 'erf', 'erfc', 
'exp', 'exp2', 'expm1', 'fabs', 'factorial', 'floor', 'fma', 'fmod', 'frexp',
 'fsum', 'gamma', 'gcd', 'hypot', 'inf', 'isclose', 'isfinite', 'isinf', 'isnan',
   'isqrt', 'lcm', 'ldexp', 'lgamma', 'log', 'log10', 'log1p', 'log2', 'modf', 'nan', 
   'nextafter', 'perm', 'pi', 'pow', 'prod', 'radians', 'remainder', 
   'sin', 'sinh', 'sqrt', 'sumprod', 'tan', 'tanh', 'tau', 'trunc', 'ulp']
'''

print(math.pi) # 3.141592653589793
print(math.factorial(5)) # 120

print("="*50)

# 별칭으로 모듈 임포트 
import math as m
print(m.ceil(12.6783920)) # 13
print(m.factorial(10)) 

# from ... import ... 방식으로 모듈안의 함수 연결 
from math import factorial, pi, ceil

print(factorial(10))
print(pi)
print(ceil(5.123))