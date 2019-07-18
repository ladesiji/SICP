# -- coding = utf-8 --

"""
    SCIP 1.2.5 关于公约数 和 素数的计算

    公约数计算，采用 欧几里得辗转相除法， gcd(a, b) = gcd(b, a mod b)

    素数计算 有两个方法：
    
    第一个方法： 从2开始，依次试一下是否能被整除，如果不能被整除，则是素数
    第二个方法： 费马小定理，如果n是一个素数，a是小于n的任意整数，那么a的n次方与a 模n 同余。
"""

def gcd(a, b):
    """
        求a, b最大公约数。
        a, b 必须是整数。
    """
    while b != 0:
        a, b = b, a % b
    return a

def isPrime(n):
    """
        判断是否是素数
        返回 bool 值
    """
    test_divisor = 2
    
    while test_divisor * test_divisor < n and n % test_divisor != 0:

        test_divisor += 1

    if n % test_divisor == 0:
        return False
    else:
        return True

print(isPrime(1997))
print(isPrime(17))

