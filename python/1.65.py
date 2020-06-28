"""
SICP in Python
1.6.5 牛顿法
"""

def square(x):
    return x * x
def square_root(a):
    return find_root(lambda x: square(x) - a)
def logarithm(a, base=2):
    return find_root(lambda x: pow(base, x) - a)
def approx_eq(x, y, tolerance=1e-6):
    return abs(x - y) < tolerance
def approx_derivative(f, x, delta=1e-6):
    df = f(x + delta) - f(x)
    return df/delta

def newton_update(f):
    def update(x):
        return x - f(x) / approx_derivative(f, x)
    return update

def iter_improve(update, test, guess=1):
    while not test(guess):
        guess = update(guess)
    return guess

def find_root(f, initial_guess=10):
    def test(x):
        return approx_eq(f(x), 0)
    return iter_improve(newton_update(f), test, initial_guess)

print(square_root(256))
print(logarithm(256, 2))