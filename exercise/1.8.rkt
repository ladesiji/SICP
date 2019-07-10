#lang planet neil/sicp
; 牛顿法立方根
;
(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x
           (* guess guess))
        (* 2 guess))
     3))

(define (good-enough? guess x)
  (< (abs (/ (- guess (improve guess x)) guess))
     0.0001))

(define (cube-root x)
  (cube-root-iter 1.0 x))


  