"""
SICP in Python
3.2.3 树形递归
"""

def fib(n):
    if n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        return fib(n - 2) + fib(n - 1)

def fib_iter(n):
    prev, current = 1, 0
    for _ in range(n-1):
        prev, current = current, prev + current
    return current


def memo(f):
    """Return a memoized version of single-argument function f."""
    cache = {}
    def memoized(n):
        if n not in cache:
            cache[n] = f(n)
        return cache[n]
    return memoized


def count_change(a, kinds=(50, 25, 10, 5, 1)):
    if a == 0:
        return 1
    if a < 0 or len(kinds) == 0:
        return 0
    d = kinds[0]
    return count_change(a, kinds[1:]) + count_change(a-d, kinds)


def count_change_iterate(a, kinds=(50, 25, 10, 5, 1)):
    result = [1] + [0] * a
    for c in kinds:
        for amount in range(c, a + 1):
            result[amount] += result[amount - c]
    return result[a]

print(count_change_iterate(1000))