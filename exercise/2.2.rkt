#lang planet neil/sicp
; 实现点和线段的数据抽象

; 点
(define (make-point x y)
  (cons x y))

(define (x-point x)(car x))

(define (y-point x)(cdr x))

(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; 实现线段
(define (make-segment start-segment end-segment)
  (cons start-segment end-segment))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (midpoint-segment segment)
  (define (avg a b)(/ (+ a b) 2.0))
  (make-point
   (avg (x-point (start-segment segment))
        (x-point (end-segment segment)))
   (avg (y-point (start-segment segment))
        (y-point (end-segment segment)))))
