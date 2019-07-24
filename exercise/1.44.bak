#lang planet neil/sicp
; f 是一个数值函数， n 是一个正整数，请构造一个f的n次重复应用。
; 如 f=x+1 则 n次重复应用是 x+n
; 如 f=x*x 则 n次重复应用是 2的n次幂

(define (repeated f n)
  (define (repeated-i result k)
    (if (= k 1)
        result
        (repeated-i (compose f result) (- k 1))))
  (repeated-i f n))

(define (compose f g)
  (lambda(x)
    (f (g x))))

(define (inc n)
  (+ n 1))

(define (square x)
  (* x x))

((compose square inc) 6)