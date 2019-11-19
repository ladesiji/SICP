#lang planet neil/sicp
; 要便利个棵树，并累积它的所有元素，我们会遇到以下三种情况
; 1、元素是空表，也就是空树，返回 '()
; 2、元素是单个节点，不是序对，就是单独的叶节点，对它使用list函数
; 3、元素有左右两个子树，使用 append 过程将两个子树相加。
; 由于 append 方法只接收 list 参数， 所以第一步和第二步的结果必须为List


(define (fringe tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree))
                      (fringe (cdr tree))))))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define x (list (list 1 2) (list 3 4)))
