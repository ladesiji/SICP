"""
SICP in Python
2.7.1 - 2.7.3 泛用函数
"""

from math import atan2, sin, cos, pi

class ComplexRI(object):
    def __init__(self, real, imag):
        self.real = real
        self.imag = imag
    @property
    def magnitude(self):
        return (self.real ** 2 + self.imag ** 2) ** 0.5
    @property
    def angle(self):
        return atan2(self.imag, self.real)
    def __repr__(self):
        return f'ComplexRI({self.real}, {self.imag})'


class ComplexMA(object):
    def __init__(self, magnitude, angle):
        self.magnitude = magnitude
        self.angle = angle
    @property
    def real(self):
        return self.magnitude * cos(self.angle)
    @property
    def imag(self): 
        return self.magnitude * sin(self.angle)
    def __repr__(self):
        return f'ComplexMA({self.magnitude}, {self.angle})'

def add_complex(z1, z2):
    return ComplexRI(z1.real + z2.real, z1.imag + z2.imag)
def mul_complex(z1, z2):
    return ComplexMA(z1.magnitude * z2.magnitude, z1.angle + z2.angle)

# 定义 + * 符号使用
ComplexRI.__add__ = lambda self, other: add_complex(self, other)
ComplexMA.__add__ = lambda self, other: add_complex(self, other)
ComplexRI.__mul__ = lambda self, other: mul_complex(self, other)
ComplexMA.__mul__ = lambda self, other: mul_complex(self, other)

a = add_complex(ComplexRI(1, 2), ComplexMA(2, pi/2))
b = mul_complex(ComplexRI(0, 1), ComplexRI(0, 1))


from math import gcd
class Rational(object):
    def __init__(self, numer, denom):
        g = gcd(numer, denom)
        self.numer = numer // g
        self.denom = denom // g
    
    def __repr__(self):
        return f'Rational({self.numer}, {self.denom})'


def add_rational(x, y):
    nx, dx = x.numer, x.denom
    ny, dy = y.numer, y.denom
    return Rational(nx*dy + ny*dx, dx*dy)

def mul_rational(x, y):
    return Rational(x.numer * y.numer, x.denom * y.denom)


def iscomplex(z):
    return type(z) in (ComplexRI, ComplexMA)

def isrational(z):
    return type(z) == Rational

def add_complex_and_rational(z, r):
    return ComplexRI(z.real + r.numer / r.denom, z.imag)

def add(z1, z2):
    """Add z1 and z2, which maybe complex or rational."""
    if iscomplex(z1) and iscomplex(z2):
        return add_complex(z1, z2)
    elif iscomplex(z1) and isrational(z2):
        return add_complex_and_rational(z1, z2)
    elif isrational(z1) and iscomplex(z2):
        return add_complex_and_rational(z2, z1)
    else:
        return add_rational(z1, z2)

c = Rational(2, 4)
print(add(a, c))


# 使用字典实现泛用函数

def type_tag(x):
    return type_tag.tas[type(x)]

type_tag.tas = {ComplexRI: 'com', ComplexMA: 'com', Rational: 'rat'}

def add(z1, z2):
    types = (type_tag(z1), type_tag(z2))
    return add.implementation[types](z1, z2)

add.implementation = {}
add.implementation[('com', 'com')] = add_complex
add.implementation[('com', 'rat')] = add_complex_and_rational
add.implementation[('rat', 'com')] = lambda x, y: add_complex_and_rational(y, x)
add.implementation[('rat', 'rat')] = add_rational

print(add(ComplexRI(1.5, 0), Rational(3, 2)))
print(add(Rational(5, 3), Rational(1, 2)))


# 泛用 操作符 

def apply(operator_name, x, y):
    tags = (type_tag(x), type_tag(y))
    key = (operator_name, tags)
    return apply.implementation[key](x, y)

def mul_complex_and_rational(z, r):
    return ComplexMA(z.magnitude * r.numer / r.denom, z.angle)

mul_rational_and_complex = lambda r, z: mul_complex_and_rational(z, r)

apply.implementation = {('mul', ('com', 'com')): mul_complex,
                        ('mul', ('com', 'rat')): mul_complex_and_rational,
                        ('mul', ('rat', 'com')): mul_rational_and_complex,
                        ('mul', ('rat', 'rat')): mul_rational}

adder = add.implementation.items()
apply.implementation.update({('add', tags): fn for (tags, fn) in adder})

e = apply('add', ComplexRI(1.5, 0), Rational(3, 2))
f = apply('mul', Rational(1, 2), ComplexMA(10, 1))
print(e)
print(f)


# 强制转换

def rational_to_complex(x):
    return ComplexRI(x.numer / x.denom, 0)

coercions = {('rat', 'com'): rational_to_complex}


def coerce_apply(operator_name, x, y):
    tx, ty = type_tag(x), type_tag(y)
    if tx != ty:
        if (tx, ty) in coercions:
            tx, x = ty, coercions[(tx, ty)](x)
        elif (ty, tx) in coercions:
            ty, y = tx, coercions[(ty, tx)](y)
        else:
            return 'No coercion possible'
    key = (operator_name, tx)
    return coerce_apply.implementation[key](x, y)

coerce_apply.implementation = {('mul', 'com'): mul_complex,
                               ('mul', 'rat'): mul_rational,
                               ('add', 'com'): add_complex,
                               ('add', 'rat'): add_rational}

x = coerce_apply('add', ComplexRI(1.5, 0), Rational(3, 2))
y = coerce_apply('mul', Rational(1, 2), ComplexMA(10, 1))
print(x)
print(y)