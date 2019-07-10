# -- coding = utf-8 --

"""
    1、实现指数运算 expt(b, n) b 的 n 次方
        分别用递归 和 迭代 两种方法实现
    2、使用连续求平方的方法实现 幂运算
        分别用递归 和迭代 两种方法实现
"""

def expt_r(b, n):
    """
        幂运算 线性递归法
    """
    if n == 0 :
        return 1
    else:
        return expt_r(b, n-1)*b


def expt_i(b, n):
    """
        幂运算 线性迭代法
    """
    def expt_iter(b, n, product):
        if n == 0:
            return product
        else:
            return expt_iter(b, n-1, b*product)
    return expt_iter(b, n, 1)


def fast_expt_r(b, n):
    """
        幂运算 平方法 线性递归
    """
    if n == 0:
        return 1
    else:
        if n % 2 == 0:
            return square(fast_expt_r(b, n // 2))
        else:
            return square(fast_expt_r(b, (n-1) // 2))*b
    
def fast_expt_i(b, n):
    """
        幂运算 平方法 线性迭代
    """
    def fast_expt_iter(b, n, product):
        if n == 0 :
            return product
        else:
            if n % 2 == 0:
                return fast_expt_iter(square(b), n//2, product)
            else:
                return fast_expt_iter(square(b), (n-1)//2, b*product)
    return fast_expt_iter(b, n, 1)


def square(x):
    return x*x


if __name__ == '__main__':
    print(f"2 的 5 次方线性递归 {expt_r(2, 5)}")
    print(f"2 的 5 次方线性迭代 {expt_i(2, 5)}")
    print(f"2 的 5 次方平方法线性递归 {fast_expt_r(2, 5)}")
    print(f"2 的 5 次方平方法线性迭代 {fast_expt_i(2, 5)}")

