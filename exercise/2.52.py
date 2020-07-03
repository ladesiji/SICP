"""
SICP in Python
2.5.2 面向对象编程
使用银行账户存款来介绍
"""

class Account(object):
    """Account"""
    interest = 0.01
    def __init__(self, account_holder, balance=0):
        self.holder = account_holder
        self.balance = balance
    
    def withdraw(self, amount):
        if amount > self.balance:
            return "Insufficient funds"
        self.balance -= amount
        return self.balance
    
    def deposit(self, amount):
        self.balance += amount
        return self.balance

class CheckingAccount(Account):
    interest = 0.01
    withdraw_change = 1
    def withdraw(self, amount):
        return Account.withdraw(self, amount + self.withdraw_change)

a = Account('Jim')
b = Account('Jack', 200)
c = CheckingAccount('Tom', 100)

pass

