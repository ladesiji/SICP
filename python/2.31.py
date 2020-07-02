"""
SICP in Python
2.32 递归列表
构造 rlist 格式为 (1, (2, (3, (4, None))))
"""
empty_rlist = None
def make_rlist(first, rest):
    return (first, rest)

def first(s):
    return s[0]

def rest(s):
    return s[1]

counts = make_rlist(1, (2, (3, (4, None))))

def len_rlist(s):
    """
    # 递归写法
    if not rest(s):
        return 1
    else:
        return 1 + len_rlist(rest(s))
    """
    # 迭代写法
    length = 0
    while s is not None:
        s, length = rest(s), length + 1
    return length

def getitem_rlist(s, k):
    """
    # 递归写法
    if k == 0:
        return first(s)
    else:
        return getitem_rlist(rest(s), k-1)
    """
    # 迭代写法
    while k > 0:
        s, k = rest(s), k - 1
    return first(s)


print(len_rlist(counts))
print(getitem_rlist(counts, 3))