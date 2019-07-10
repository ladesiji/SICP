#lang sicp
; 求三个数中较大两个数的和
(define (sum-max-number x y z)
  (cond ((> x y) (if (> y z) (+ x y) (+ x z)))
        (else (if (> x z) (+ x y) (+ y z)))))

(sum-max-number 1 2 3)
(sum-max-number 6 5 4)
(sum-max-number 3 7 4)