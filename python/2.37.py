"""
SICP in Python
2.3.7 接口约定
多个组件模块共享数据格式，可以将上一个函数的输出用于下一个函数的输入。
通过两个问题来介绍：
1、对前 n 个斐波那契数中的偶数求和
2、列出一个名称中的所有缩写字母
"""

def fib(n):
    prev, current = 0, 1  # current is the first Fibonacci number.
    for _ in range(n - 1):
        prev, current = current, prev + current
    return current

def is_even(n):
    return n % 2 == 0

def sum_fib_even(n):
    return sum(filter(is_even, map(fib, range(1,n))))

print(sum_fib_even(20))
assert sum_fib_even(20) == 3382

def acronym(name):
    return tuple(filter(lambda s: len(s) and s.isupper(), map(lambda s: s[0], name.split())))

print(acronym("University of California Berkeley Undergraduate Graphics Group"))

# 使用列表生成式来完成上述计算过程
print(sum(fib(k) for k in range(1, 20) if fib(k) % 2 == 0))
words = "University of California Berkeley Undergraduate Graphics Group"
print(tuple(w[0] for w in words.split() if w[0].isupper()))
