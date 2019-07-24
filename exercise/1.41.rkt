#lang planet neil/sicp
; 定义一个double过程，以有一个参数的过程为参数，返回一个过程
; 这个过程将来原的参数过程应用两次。
; 如inc 是给参数加1的过程，(double inc) 将给参数加2。
; 求 (((double (double double)) inc) 5)

(define (double f)
  (lambda(x) (f (f x))))

(define (inc x)
  (+ x 1))
(define (square x)
  (* x x))

(((double (double double)) inc) 5)