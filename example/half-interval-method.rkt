#lang planet neil/sicp
; 区间折半主方法 寻找f(x)=0的根。
; f 是一个连续函数，对于给定点 a b 有 f(a) < 0 < f(b), 那a和b之间必然有一个零点。
; 令c = (/ (+ a b) 2.0) 如果 f(c) > 0，则在 a 和 c之间必然有一个零点，如果f(c)<0, 那c和b之间必然有一个f的零点
; 继续这样做下去，就能确定出越来越小的区间，保证其中必然有一个零点，当区间足够小，就可以结束运算。

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
(define (average x y)
  (/ (+ x y) 2.0))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sigh" a b)))))
