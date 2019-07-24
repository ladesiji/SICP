#lang planet neil/sicp
; 无穷连分式

; 迭代法
(define (cont-frac n d k)
  (define(cont-frac-i result term)
    (if (= term 0)
        result
        (cont-frac-i (/ (n term)
                        (+ (d term) result))
                     (- term 1))))
  (cont-frac-i 0 k))

; 递归法
(define (con-frac-r n d k)
  (define (frac-rec i)
    (/ (n i)
       (+ (d i)
          (if (= i k)
              0
              (frac-rec (+ i 1))))))
  (frac-rec 1))


