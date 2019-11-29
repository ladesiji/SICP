# -- coding = utf-8 --

"""
SICP 第二章 层次结构部分 习题 2.32
将一个集合表示为元素各不相同的列表，求这个集合的所有子集。
例：集合{1, 2, 3} 的所有子集为{{}, {1}, {2}, {3}, {1, 2}, {2, 3}, {1, 3}, {1, 2, 3}}

"""
s = [1, 2, 3]
result = []
def subsets(s):
    if not s:
        return []
    else:
        return list(map(lambda x:[s[0], x], subsets(s[1:])))

print(subsets(s))