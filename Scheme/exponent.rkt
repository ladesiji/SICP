#lang planet neil/sicp
; 幂 函数
; 线性递归

(define (expt-r b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))

; 线性迭代

(define (expt-i b n)
  (define (expt-iter b n product)
    (if (= n 0) product
        (expt-iter b (- n 1) (* b product))))
  (expt-iter b n 1))

; 使用连续求平方来计算幂: 线性递归法

(define (fast-expt-r b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-r b (/ n 2))))
        (else (* b (fast-expt-r b (- n 1))))))
(define (even? n)
  (= (remainder n 2) 0))
(define (square x)
  (* x x))

; 使用连续求平方法计算幂-线性迭代法
(define (fast-expt-i b n)
  (define (fast-expt-iter b n product)
    (cond ((= n 0) product)
          ((even? n) (fast-expt-iter (square b) (/ n 2) product))
          (else (fast-expt-iter (square b) (/ (- n 1) 2) (* b product)))))
  (fast-expt-iter b n 1))
  