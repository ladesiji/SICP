#lang planet neil/sicp
; 迭代法求连分式

(define (cont-frac n d k)
  (define (cont-frac-i result iterm)
    (if (= iterm 0)
        result
        (cont-frac-i (/ (n iterm)
                        (+ (d iterm) result))
                     (- iterm 1))))
  (cont-frac-i 0 k))

(define (tan-cf x k)
  (cont-frac (lambda (i)
               (if (= i 1)
                   x
                   (- (* x x))))
             (lambda (i)
               (- (* i 2) 1))
             k))
