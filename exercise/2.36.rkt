#lang planet neil/sicp
#|
第二章练习2.36
过程accumulate-n 与 accumulate类似，但处理的序列中每个元素等长序列，将子序列中对应项进行累积。
先组合每个子列表的第一个元素，再组合子列表的第二个元素，依次完成，最后结果是一个序列。
如x 为 ((1 2 3)(4 5 6)(7 8 9)(10 11 12)) 那么 (accumulate-n + 0 x) 的值为(22 26 30).
|#

; 先定义要用到的累积过程 accumulate
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

; 再定义 map 过程
#|

(define (map proc sequence) ; 普通方法
  (if (null? sequence)
      nil
      (cons (proc (car sequence))
            (map proc (cdr sequence)))))
|#

(define (map proc sequence) ; 使用 accumulate 的方法
  (accumulate (lambda(x y)
                (cons (proc x)
                      y))
              nil sequence))

(define (accumulate-n op initial sequence)
  (if (null? (car sequence)) ; 这一句是关键，当子列表中没有元素时结束递归
      nil
      (cons (accumulate op initial (map car sequence))
            (accumulate-n op initial (map cdr sequence)))))

(define x (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(display (accumulate-n + 0 x))