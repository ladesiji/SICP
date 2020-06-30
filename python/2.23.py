"""
SICP in Python
2.2.3 抽象的界限
以有理数的抽象为例
"""

def add_rat(x, y):
    nx, dx = numer(x), denom(x)
    ny, dy = numer(y), denom(y)
    return make_rat(nx * dy + ny * dx, dx * dy)

def mul_rat(x, y):
    return make_rat(numer(x) * numer(y), denom(x) * denom(y))

def eq_rat(x, y):
    return numer(x) * denom(y) == numer(y) * denom(x)


# 用函数来保存数组

def make_rat(x, y):
    g = gcd(x, y)
    def dispatch(m):
        if m == 0:
            return x // g
        if m == 1:
            return y // g
    return dispatch

def gcd(x, y):
    if x < y:
        x, y = y, x
    while y != 0:
        x, y = y, x % y
    return x

def getitem_pair(m, i):
    return m(i)

def numer(x):
    return getitem_pair(x, 0)

def denom(y):
    return getitem_pair(y, 1)

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