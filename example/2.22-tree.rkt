#lang planet neil/sicp
; cons 组成的数据对，是一个节点型的数据结构。
; 能够用 cons 天然组成链表，也可以组成二叉树。

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(define x (cons (list 1 2 3 4) (list 1 2 3 4)))
(count-leaves x)

(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(scale-tree x 10)


(define (scale-tree-n tree factor)
  (map (lambda (sub-tree)
          (if (pair? sub-tree)
              (scale-tree-n sub-tree factor)
              (* sub-tree factor)))
        tree))

(scale-tree-n x 10)