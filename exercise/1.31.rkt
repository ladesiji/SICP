#lang planet neil/sicp

;  实现累乘的过程，如阶乘

(define (identity x) x)
(define (inc n) (+ n 1))

; 线性递归法
(define (product term  a next b)
  (if (> a b)
      1
      (* (term a)
         (product term  (next a) next b))))



; 线性迭代法
(define (product-i term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))


; 实现累乘求 Pi
; pi/4 = (2*4*4*6*6*8*...)/(3*3*5*5*7*7...)
(define (add n) (+ n 2))
(define (square x) (* x x))
(define (f n)
  (/ (- (square n) 1)
     (square n)))

