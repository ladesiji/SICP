#lang planet neil/sicp
; f 和 g 是单参数函数。f 在 g 之后的复合函数为 f(g(x))
; 请定义一个函数compose 实现函数复合

(define (compose f g)
  (lambda(x)
    (f (g x))))

(define (inc n)
  (+ n 1))

(define (square x)
  (* x x))

((compose square inc) 6)