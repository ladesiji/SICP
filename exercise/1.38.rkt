#lang planet neil/sicp
; 使用连分式求自然对数 e
; N 为 1
; D 为 1，2，1，1，4，1，1，6，1，1，8，1

(define (d n)
  (if (= (remainder n 3) 2)
      (/ (+ n 1) 1.5)
      1))

; 使用迭代法计算连分式
(define (cont-frac n d k)
  (define (cont-frac-i result term)
    (if (= term 0)
        result
        (cont-frac-i (/ (n term)
                       (+ (d term) result))
                    (- term 1))))
  (cont-frac-i 0 k))

(define (euler-e k)
  (+ 2 (cont-frac (lambda(i) 1.0)
             d
             k)))

