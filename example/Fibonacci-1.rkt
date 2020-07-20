#lang planet neil/sicp
; 斐波那契数列
; 递归算法

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 2))
                 (fib (- n 1))))))
; 迭代算法
(define (fib-i n)
  
  (define (fib-iter a b count)
    (if (= count 0)
        a
        (fib-iter b (+ a b)(- count 1))))
  (fib-iter 0 1 n))



