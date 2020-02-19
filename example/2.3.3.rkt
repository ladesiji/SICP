#lang planet neil/sicp
#|
用平衡二叉树来表示集合

2.3.3 节例题

|#

; 实现tree
(define (entry tree)(car tree))

(define (left-branch tree)(cadr tree))

(define (right-branch tree)(caddr tree))

(define (make-tree entry left right)
  (list (entry left right)))

; 实现集合方法
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch tree)))
        ((> x (entry set))
         (element-of-set? x (right-branch tree)))))

(define (adjoin-set x set)
  (cond ((null? set)
         (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch)
                    (adjoin-set x (right-branch set))))))
                    
        