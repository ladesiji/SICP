#lang planet neil/sicp
; SICP 第二章 2.2节例题

(define  (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))
(list-ref squares 4)

; 递归方法求列表长度
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define odds (list 2 4 6 8))
(length odds)

; 迭代方法求列表长度
(define (length-i items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ count 1))))
  (length-iter items 0))
(length-i odds)

; 列表的 append 方法，实现两个列表的合并

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append (cdr list1) list2))))

(append squares odds)
(append odds squares)
(append odds (list 10))