"""
SICP in python
1.6.1 作为参数的函数
"""

def sum_naturals_old(n):
    """
    计算 1..n 自然数和
    """
    total, k = 0, 1
    while k <= n:
        total, k = total + k, k + 1
    return total

def sum_cubes_old(n):
    """
    计算 1..n 立方和
    """
    total, k = 0, 1
    while k <= n:
        total, k = total + pow(k, 3), k + 1
    return total

def sum_pi_old(n):
    """"
    计算 pi 的级数 8*(1/(1*3) + 1/(5*7) + 1/(9*11))
    """
    total, k = 0, 1
    while k <= n:
        total, k = total + 8 / (k * (k + 2)), k + 4
    return total

def summation(n, term, next):
    """
    一种通用的模板
    """
    total, k = 0, 1
    while k <= n:
        total, k = total + term(k), next(k)
    return total

def cube(k):
    return pow(k, 3)

def successor(k):
    return k + 1

def pi_term(k):
    return 8 / (k * (k + 2))

def pi_next(k):
    return k + 4

def identity(k):
    return k

def sum_naturals(n):
    return summation(n, identity, successor)

def sum_cubes(n):
    return summation(n, cube, successor)

def sum_pi(n):
    return summation(n, pi_term, pi_next)

print(sum_naturals(100))
print(sum_cubes(3))
print(sum_pi(1e6))