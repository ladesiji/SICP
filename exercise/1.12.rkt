#lang sicp
(define (pascal-recursion-element x y)
  (if (= y 1) 1
      (if (= x y) 1
          (+ (pascal-recursion-element (- y 1) x)
             (pascal-recursion-element (- y 1) (- x 1))))))

(define (f n m)
  (cond ((> m n) 0)
        ((= m n) 1)
        ((= m 1) 1)
        (else (+ (f (- n 1) (- m 1)) (f (- n 1) m)))))

