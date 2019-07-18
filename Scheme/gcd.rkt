#lang planet neil/sicp
; 欧几里得辗转相除法求最大公约数
; gcd(a, b) = gcd(b, a mod b)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(remainder 12 4)