"""
SICP in Python
2.6.1-3 用函数实现Python的类
以银行账户为例
"""

def make_instance(cls):
    """Return a new object instance, which is dispatch dictionary."""
    def get_value(name):
        if name in attributes:     # attributes is a dictionary of name
            return attributes[name]:
        else:
            value = cls['get'](name)
            return bind_method(value, instance)
    def set_value(name, value):
        attributes[name] = value
    attributes = {}
    instance = {'get': get_value, 'set', set_value}
    return instance
