"""
SICP in Python
1.6.2 作为一般方法的函数

"""

def iter_improve(update, test, guess=1):
    """
    updata: a function to improve guess
    test: a function to test guess 
    """
    while not test(guess):
        guess = update(guess)
    return guess

def near(x, f, g):
    return approx_eq(f(x), g(x))

def approx_eq(x, y, tolerance=1e-6):
    return abs(x - y) < tolerance

def golden_update(guess):
    """
    黄金分割的改进函数
    """
    return 1/guess + 1

def succesor(k):
    return k + 1

def square(k):
    return pow(k, 2)

def golden_test(guess):
    return near(guess, square, succesor)



phi = 1/2 + pow(5, 1/2)/2
print(phi)
def near_test():
    assert near(phi, square, succesor), "phi * phi is not near phi + 1"

print(iter_improve(golden_update, golden_test))