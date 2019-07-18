#lang planet neil/sicp
; 求素数
; 从2开始，使用整数逐一试一试能否被整除

(define (smallest-divisor n)
  (define (square x) (* x x))
  (define (divides? a b) (= (remainder a b) 0))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? n test-divisor) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (find-divisor n 2))

(define (is-prime? n)
  (= (smallest-divisor n) n))
