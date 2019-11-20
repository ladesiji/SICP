#lang planet neil/sicp
; 递归计算过程 和 迭代计算过程
;
; 递归计算过程 由解释器维持，运算的链条越长，要保存的信息越多
;
; 迭代计算过程 状态可以用固定数目的状态变量描述的计算过程。
; 同时存在一套固定规则，描述计算状态到下一个的转换。
; 迭代计算过程可以停下来，重新唤醒只需提供变量值

; 下面以阶乘为例，分别给出递归计算过程 和 迭代计算过程

; 阶乘的递归计算过程
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

; 阶乘的迭代计算过程
(define (fact n)
  (define (fact-iter product counter)
    (if (> counter n)
        product
        (fact-iter (* counter product)
                   (+ counter 1))))
  (fact-iter 1 1))
