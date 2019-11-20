#lang planet neil/sicp
#|
   使用Honor规则来计算多项式,使用之前的累积模块
( ··· (（anx+an_1)x+an_2)x + ··· + a1)x + a0)
|#

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))
