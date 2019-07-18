#lang planet neil/sicp
; 使用迭代方法实现 sum 过程

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (identity x) x)

(define (inc n)(+ n 1))

(define (cube x)(* x x x))
