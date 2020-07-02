"""
SICP in Python
2.4.4 使用函数抽象列表
"""
empty_rlist = None

def make_rlist(first, rest):
    return (first, rest)

def first(s):
    return s[0]

def rest(s):
    return s[1]

def len_rlist(s):
    length = 0
    while s != empty_rlist:
        s, length = rest(s), length + 1
    return length

def getitem_rlist(s, k):
    while k > 0:
        s, k = rest(s), k - 1
    return first(s)

def make_mutable_rlist():
    """Return a functional implementation of a mutable recursive list."""
    contents = empty_rlist
    def dispatch(message, value=None):
        nonlocal contents
        if message == 'len':
            return len_rlist(contents)
        elif message == 'getitem':
            return getitem_rlist(contents, value)
        elif message == 'push_first':
            contents = make_rlist(value, contents)
        elif message == 'pop_first':
            f = first(contents)
            contents = rest(contents)
            return f
        elif message == 'str':
            return str(contents)
    return dispatch

def to_mutable_rlist(source):
    s = make_mutable_rlist()
    for element in reversed(source):
        s('push_first', element)
    return s

a = list(range(1,10))

b = to_mutable_rlist(a)
print(b("str"))
print(b("pop_first"))
print(b("str"))

