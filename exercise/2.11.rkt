#lang planet neil/sicp
;; 使用中心点和宽度来表示区间

; 定义区间
(define (make-center-width c w)
  (cons (min (- c w) (+ c w))
        (max (- c w) (+ c w))))

(define lower-bound car)
(define upper-bound cdr)
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

; 定义计算
(define (add-interval x y)
  (make-center-width (+ (center x) (center y))
                     (+ (width x) (width y))))

(define (sub-interval x y)
  (make-center-width (- (center x) (center y))
                     (+ (width x) (width y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))

    (make-center-width ((/ (+ (max p1 p2 p3 p4)
                              (min p1 p2 p3 p4))
                           2.0)
                        (/ (- (max p1 p2 p3 p4)
                                     (min p1 p2 p3 p4))
                                  2.0)))))

(define (div-interval x y)
  (if (< 0 (* (upper-bound y) (lower-bound y)))
      (error "Division error (interval span 0)" y)
      (mul-interval x
                    (cons (/ 1.0 (upper-bound y))
                          (/ 1.0 (lower-bound y))))))