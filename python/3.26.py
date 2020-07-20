"""
SICP in Python
3.2.6 求幂
"""

def exp(b, n):
    if n == 1:
        return b
    return b * exp(b, n - 1)


def exp_iter(b, n):
    ans = 1
    for _ in range(n):
        ans *= b
    return ans

def exp_fast(b, n):
    if n == 0:
        return 1
    elif n % 2 == 0:
        return square(exp_fast(b, n // 2))
    else:
        return b * exp_fast(b, n - 1)

def square(x):
    return x * x

print(exp(2, 100))
print(exp_iter(2, 100))
print(exp_fast(2, 100))
