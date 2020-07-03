"""
SICP in Python
2.4.5 字典实现
用函数来实现字典
"""

def make_dic():
    records = []
    def getitem(key):
        for k, v in records:
            if k == key:
                return v
    def setitem(key, value):
        for item in records:
            if item[0] == key:
                item[1] == value
                return
        records.append([key, value])
    def dispatch(message, key=None, value=None):
        if message == 'getitem':
            return getitem(key)
        elif message == 'setitem':
            setitem(key, value)
        elif message == 'keys':
            return tuple(k for k, _ in records)
        elif message == 'values':
            return tuple(v for _ , v in records)
    return dispatch

d = make_dic()

d('setitem', 3, 9)
d('setitem', 4, 16)
d('setitem', 5, 25)

print(d('getitem', 4))
print(d('getitem', 5))
print(d('keys'))
print(d('values'))
