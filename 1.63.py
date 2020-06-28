"""
SICP in Python
1.6.3 嵌套定义
以求平方根为例，用来解决多个参数
"""

def iter_improve(update, test, guess=1):
    # 过程抽象
    while not test(guess):
        guess = update(guess)
    return guess

def average(x, y):
    return (x + y) / 2

def near(x, f, g):
    return approx_eq(f(x),g(x))

def approx_eq(x, y, tollance=1e-6):
    return abs(x-y) < tollance

def square_root(x):
    def update(guess):
        return average(guess, x / guess)
    def test(guess):
        return approx_eq(pow(guess,2), x)
    return iter_improve(update, test)

print(square_root(16))