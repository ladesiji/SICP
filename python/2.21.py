"""
SICP in Python
2.2.1 有理数的抽象
"""

# 有理数的方法
def add_rat(x, y):
    nx, dx = numer(x), denom(x)
    ny, dy = numer(y), denom(y)
    return make_rat(nx * dy + ny * dx, dx * dy)

def mul_rat(x, y):
    return make_rat(numer(x) * numer(y), denom(x) * denom(y))

def eq_rat(x, y):
    return numer(x) * denom(y) == numer(y) * denom(x)

# 有理数的底层实现
from operator import getitem
def make_rat(x, y):
    g = gcd(x, y)
    return (x // g, y // g)

def numer(x):
    return getitem(x, 0)

def denom(x):
    return getitem(x, 1)

def gcd(x, y):
    if x < y:
        x, y = y, x
    while y > 0:
        x, y = y, x % y
    return x

def str_rat(x):
    return f'{numer(x)}/{denom(x)}'

half = make_rat(1, 2)
third = make_rat(1, 3)
print(type(half))
print(type(third))

print(str_rat(half))
print(str_rat(add_rat(half, third)))
print(str_rat(mul_rat(half, third)))
print(str_rat(add_rat(half, half)))
