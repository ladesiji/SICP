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

; 线性迭代法求积
(define (fast-mult-i a b)
  (define (fast-mult-iter a b product)
    (cond ((= b 0) 0)
          ((= b 1) (+ a product))
          ((even? b) (fast-mult-iter (double a) (halve b) product))
          (else (fast-mult-iter a (- b 1) (+ a product)))))
  (fast-mult-iter a b 0))

; 线性递归法 求积
(define (fast-mult-r a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult-r a (halve b))))
        (else (+ a (double (fast-mult-r a (halve (- b 1))))))))


(fast-mult-i 3 100)
(fast-mult-r 3 100)