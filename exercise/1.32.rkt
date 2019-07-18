#lang planet neil/sicp
; 定义一个 accumulate 过程 实现 sum 和 product 的一般情况
; 其中 combiner 描述 如合将当前项与前面各项组合起来
; null-value 参数描述 当所有项用完时的基准值

; 递归过程实现
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))
(define (identity x) x)
(define (inc n) (+ n 1))

(define (sum term a next b)
  (accumulate + 0 term a next b))
(define (product term a next b)
  (accumulate * 1 term a next b))

; 迭代过程实现
(define (accumulate-i combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner a result))))
  (iter a null-value))
