"""
SICP in Python
3.2.1 递归函数
"""

def pig_latin(w):
    """Return the Pig Latin equivalent of English word w."""
    if starts_with_a_vowel(w):
        return w + 'ay'
    else:
        return pig_latin(w[1:]+w[0])

def starts_with_a_vowel(w):
    """Return whether w begins with a vowel"""
    return w[0].lower() in "aeiou"

print(pig_latin("pun"))
