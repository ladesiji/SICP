#lang planet neil/sicp
;; 当被除区间包括零时没有意义
;; 区间的定义
(define (make-interval x y)
  (cons x y))

(define (lower-bound x)(car x))
(define (upper-bound x)(cdr x))


(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (< 0 (* (lower-bound y) (upper-bound y)))
      (error "Division error (interval spans 0)" y)
      (mul-interval x
                (make-interval (/ 1.0 (upper-bound))
                               (/ 1.0 (lower-bound))))))