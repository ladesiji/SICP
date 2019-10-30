#lang planet neil/sicp
;; 实现一个矩形

(define (make-point x y)(cons x y))
(define (x-point p)(car p))
(define (y-point p)(cdr p))

(define (make-rect bottom-left top-right)
  (cons bottom-left top-right))

(define (bottom-left rect)(car rect))
(define (bottom-right rect)
  (make-point (x-point (cdr rect))
              (y-point (car rect))))
(define (top-left rect)
  (make-point (x-point (car rect))
              (y-point (cdr rect))))
(define (top-right rect)(cdr rect))

(define (width-rect rect)
  (abs (- (x-point (bottom-left rect))
          (x-point (bottom-right rect)))))
(define (high-rect rect)
  (abs (- (y-point (top-left rect))
          (y-point (bottom-left rect)))))

;; Public methods
(define (area-rect rect)
  (* (width-rect rect)
     (high-rect rect)))
(define (perimeter-rect rect)
  (* 2 (+ (width-rect rect)
          (high-rect rect))))

;; Usage
(define r (make-rect (make-point 1 1)
                     (make-point 3 7)))
(area-rect r)
(perimeter-rect r)