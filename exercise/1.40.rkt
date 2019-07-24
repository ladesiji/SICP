#lang planet neil/sicp
; 牛顿法求不动点

; 先求函数的导数,其中dx为很小的数
; Dg(x) =  (g(x + dx)- g(x)) / dx

(define (deriv g)
  (define dx 0.00001)
  (lambda (x)
    (/ (- (g (+ x dx))
          (g x))
       dx)))

; 牛顿法
; f(x) = x - g(x)/Dg(x)

(define (newton-transform g)
  (lambda(x)
    (- x (/ (g x) ((deriv g) x)))))

; 求不动点

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; 牛顿法求不动点
(define (newton-method g first-guess)
  (fixed-point (newton-transform g) first-guess))

; 求三次方程 x3 + ax2 + bx + c的零点
(define (cubic a b c)
  (lambda(x)
    (+ (* x x x)
       (* a x x)
       (* b x)
       c)))
