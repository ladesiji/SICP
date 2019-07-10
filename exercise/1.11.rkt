#lang planet neil/sicp
; 函数f(n) = f(n-1) + 2f(n-2) + 3f(n-3)  n<3 f(n)=n
; 斐波那契数列增强版

; 递归方法实现

(define (f-r n)
  (cond ((< n 3) n)
        (else (+ (f-r (- n 1))
                 (* (f-r (- n 2)) 2)
                 (* (f-r (- n 3)) 3)))))

; 迭代方法实现
(define (f-i n)
  (define (f-iter a b c n)
    (if (= n 0)
         a
         (f-iter b c (+ (* a 3) (* b 2) c)
                 (- n 1))))
  (f-iter 0 1 2 n))

