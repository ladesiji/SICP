#lang planet neil/sicp
; 迭代式改进

(define (iterative-improve good-enough? improve)
  (lambda(x)
    (define (iter n)
      (if (good-enough? n)
          n
          (iter (improve n))))
    (iter x)))

(define (close-enough? a b)
  (< (abs (- a b)) 0.000001))

(define (fixed-point f first-guess)
  ((iterative-improve (lambda (x) (close-enough? x (f x)))
                      f)
   first-guess))

; 平均阻尼过程
(define (average-damp f)
  (lambda(x)
    (/ (+ x (f x)) 2.0)))
(define (sqrt x)
  (fixed-point (average-damp (lambda(y) (/ x y))) 1.0))

(define (cube-root x)
  (fixed-point (average-damp (average-damp (lambda (y) (/ x (* y y))))) 1.0))