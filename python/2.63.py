"""
SICP in Python
2.6.1-3 用函数实现Python的类
以银行账户为例
"""

def make_instance(cls):
    """Return a new object instance, which is dispatch dictionary."""
    def get_value(name):
        if name in attributes:     # attributes is a dictionary of name
            return attributes[name]
        else:
            value = cls['get'](name)
            return bind_method(value, instance)
    def set_value(name, value):
        attributes[name] = value
    attributes = {}
    instance = {'get': get_value, 'set': set_value}
    return instance

def bind_method(value, instance):
    """Return a bound method if value is callable, or value otherwise."""
    if callable(value):
        def method(*args):
            return value(instance, *args)
        return method
    else:
        return value
    
def make_class(attributes, base_class=None):
    """Return a new class, which is a dispatch dictionary."""
    def get_value(name):
        if name in attributes:
            return attributes[name]
        elif base_class is not None:
            return base_class['get'](name)
    def set_value(name, value):
        attributes[name] = value
    def new(*args):
        return init_instance(cls, *args)
    cls = {'get': get_value, 'set': set_value, 'new': new}
    return cls

def init_instance(cls, *args):
    """Return a new object with type cls, initialized with args."""
    instance = make_instance(cls)
    init = cls['get']('__init__')
    if init:
        init(instance, *args)
    return instance

# 用上面的类 和 实例 来实现一个银行账户存取款例子

def make_account_class():
    """Return a account class, which has deposit and withdraw methods."""
    def __init__(self, account_holder):
        self['set']('holder', account_holder)
        self['set']('balance', 0)
    def deposit(self, amount):
        """Increase the account balance by amount and return the new balance."""
        new_balance = self['get']('balance') + amount
        self['set']('balance', new_balance)
        return self['get']('balance')
    def withdraw(self, amount):
        """Decrease the account balance by amount and return the new balance."""
        balance = self['get']('balance')
        if amount > balance:
            return 'Insufficient funds'
        self['set']('balance', balance - amount)
        return self['get']('balance')
    return make_class({'__init__': __init__, 
                       'deposit': deposit,
                       'withdraw': withdraw,
                       'interest': 0.02})


Account = make_account_class()
jim_acct = Account['new']('jim')
print(jim_acct['get']('holder'))
print(jim_acct['get']('interest'))
print(jim_acct['get']('deposit')(20))
print(jim_acct['get']('withdraw')(5))

# 类的继承
def make_checking_account_class():
    """Return the checking account class, which imposes a $1 withdraw fee."""
    def withdraw(self, amount):
        return Account['get']('withdraw')(self, amount + 1)
    return make_class({'withdraw': withdraw, 'interest': 0.01}, Account)


CheckingAccount = make_checking_account_class()
jack_acct = CheckingAccount['new']('jack')
print(jack_acct['get']('holder'))
print(jack_acct['get']('interest'))
print(jack_acct['get']('deposit')(20))
print(jack_acct['get']('withdraw')(5))