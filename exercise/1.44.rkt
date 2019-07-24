#lang planet neil/sicp
; f 是一个函数，dx 是一个很小的数值，f 的平滑也是一个函数
; 在点x的值是f(x-dx)、f(x)、f(x+dx) 的平均值

; 平滑函数
(define dx 0.0001)
(define (smooth f)
  (lambda(x)
    (/ (+ (f (+ x dx))
          (f x)
          (f (- x dx)))
       3)))

; 平滑 n 次函数
(define (n-fold-smooth f n)
  ((repeated smooth n) f))

; 上一题需要用到的过程
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

