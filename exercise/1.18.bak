#lang planet neil/sicp
; 通过反复做加法的方法定义乘法，再用双倍法 求乘积

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(define (double a)
  (* a 2))

(define (halve a)
  (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult a (halve b))))
        (else (+ a (double (fast-mult a (halve (- b 1))))))))
