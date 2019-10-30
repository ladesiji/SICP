#lang planet neil/sicp
;; 将a b 序对表示为2的a次方与3的b次方的乘积，实现序对的操作。

(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car z)
  (define (devisble-by-3? a)
    (= (remainder a 3) 0))
  (if (devisble-by-3? z)
      (car (/ z 3))
      (/ (log z) (log 2))))

(define (cdr z)
  (if (even? z)
      (cdr (/ z 2))
      (/ (log z) (log 3))))