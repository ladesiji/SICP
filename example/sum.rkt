#lang planet neil/sicp
; 1.31 过程作为参数

; 计算 a 到 b 的整数和
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

; 计算给定范围内整数的立方和
(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))
(define (cube a) (* a a a))

; 计算序列和 （1/（1*3） + 1/（5*7） + 1/（9*11） + ...)
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

; 定义一个抽象的过程
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; 定义自加过程
(define (inc n) (+ n 1))

; 定义恒等函数
(define (identity x) x)

; 使用立方过程和自加过程实现 立方和
(define (sum-cubes-new a b)
  (sum cube a inc b))

; 使用恒等过程和自加过程实现 整数和
(define (sum-integers-new a b)
  (sum identity a inc b))

; 序列和求 pi-sum
(define (pi-sum-new a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

