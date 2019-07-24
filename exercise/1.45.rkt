#lang planet neil/sicp
; 使用 average-damp 和 repeated 来计算n 次方根
; 求平方根
(define (sqrt x)
  (fixed-point (average-damp (lambda(y) (/ x y))) 1.0))
; 求立方根
(define (cube-root x)
  (fixed-point ((repeated average-damp 5) (lambda(y) (/ x (* y y)))) 1.0))
;求 n 次方根
(define (n-root x n)
  (fixed-point ((repeated average-damp n) (lambda(y) (/ x (exp y (- n 1))))) 1.0))

;幂过程
(define (exp x n)
  (define (exp-iter product k)
    (if (= k 0)
        product
        (exp-iter (* x product) (- k 1))))
  (exp-iter 1 n))


; 不动点过程
(define (fixed-point f first-guess)
  (define tolerance 0.000001)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; 平均阻尼过程
(define (average-damp f)
  (lambda(x)
    (/ (+ x (f x)) 2.0)))



; 重复过程
(define (repeated f n)
  (define (iter result k)
    (if (= k 1)
        result
        (iter (compose f result) (- k 1))))
  (iter f n))

; 复合过程
(define (compose f g)
  (lambda(x)
    (f (g x))))


