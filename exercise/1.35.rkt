#lang planet neil/sicp
(define (fixed-point f first-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
(define tolerance 0.00001)

(define average (lambda (a b) (/ (+ a b) 2.0)))
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
(fixed-point (lambda (x) (average x (+ 1 (/ 1 x)))) 1.0)