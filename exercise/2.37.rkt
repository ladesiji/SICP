#lang planet neil/sicp
#|
第二章练习2.37
使用序列操作完成向量和矩陈的运算。
向量用 v = (vi) 表示如 (1 2 3 4)
矩阵用 m = (mij) 表示如 4*3 矩阵 ((1 2 3 4)(5 6 7 8)(9 10 11 12))
(dot-product v w) 向量的乘法 返回和 sum（viwi)
(matrix-*-vector m v) 矩阵乘以向量，返回向量t 其中 ti = sumj(mij * vj)
(matrix-*-matrix m n) 矩阵乘法，返回矩阵p 其中 pij = sumk(mik * nkj)
(transpose m) 返回矩阵n 其中 nij = mji
|#

; 需要用到2.36的两个累积
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op initial sequence)
  (if (null? (car sequence))
      nil
      (op (accumulate op initial (map car sequence))
          (accumulate-n op initial (map cdr sequence)))))

; 向量乘法
(define (dot-product v w)
  (accumulate + 0 (map * v w)))  ; 这里的map是自带的函数，可以处理多个序列参数

; 矩阵乘向量
(define (matrix-*-vector m v)
  (map (lambda(x)(dot-product v x)) m))

; 矩阵转置
(define (transpose m)
  (accumulate-n cons nil m))

; 矩阵乘法
(define (matrix-*-matrix m n)
  (map (lambda(x)(matrix-*-vector (transpose n) x)) m))

