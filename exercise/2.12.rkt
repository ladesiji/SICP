#lang planet neil/sicp
;; 使用百分比和中心点的形式表示区间

(define (make-interval a b)
  (if (< a b)
      (cons a b)
      (cons b a)))
(define lower-bound car)
(define upper-bound cdr)
(define (center i)
  (/ (+ (upper-bound i)
        (lower-bound i)) 2))

;; Percent is between 0 and 100.0
(define (make-interval-center-percent c pct)
  (let ((width (* c (/ pct 100.0))))
    (make-interval (- c width) (+ c width))))

(define (percent-tolerance i)
  (let ((center (/ (+ (upper-bound i) (lower-bound i)) 2.0))
        (width (/ (- (upper-bound i) (lower-bound i)) 2.0)))
    (* (/ width center) 100)))

 ;; A quick check: 
  
 (define i (make-interval-center-percent 10 50)) 
 (lower-bound i) 
 (upper-bound i) 
 (center i) 
 (percent-tolerance i) 