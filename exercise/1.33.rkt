#lang planet neil/sicp
; 通过引入一个过滤器(filter) 来处理被组合的项，完成accumulate的列一般版本
; 在计算的过程中只组合满足过滤条件的项
; a) 求出区间 a b 内所有素数和
; b) 求小于 n 的所有与 n 素素的正整数的 乘积

; 线性递归
(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a)
          (combiner (term a)
                    (filtered-accumulate filter combiner null-value term (next a) next b))
          (combiner null-value
                    (filtered-accumulate filter combiner null-value term (next a) next b)))))
; 线性迭代
(define (filtered-accumulate-i filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter a)
            (iter (next a) (combiner a result))
            (iter (next a) result))))
  (iter a null-value))

; 判断是否是素数
(define (prime? n)
  (define (small-divisor n)
    
    (define (square x) (* x x))
    (define (divides? a b)
      (= (remainder a b) 0))
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? n test-divisor) test-divisor)
            (else (if (> test-divisor 2) (find-divisor n (+ test-divisor 2))
                      (find-divisor n (+ test-divisor 1))))))
    (find-divisor n 2))
 (if (= n 1) #f
     (= n (small-divisor n))))

; 恒等函数
(define (identity x) x)
; 自加函数
(define (inc n) (+ n 1))

; 求 a 之间 b 素数和
(define (sum-prime a b)
  (filtered-accumulate prime? + 0 identity a inc b))

; 求 a 之间 b 素数积
(define (product-prime a b)
  (filtered-accumulate-i prime? * 1 identity a inc b))
