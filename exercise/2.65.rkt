#lang planet neil/sicp
;结合例题和2.63 2.64，完成平衡二叉树构造的集合


;例题部分

(define (entry tree)(car tree))
(define (left-branch tree)(cadr tree))
(define (right-branch tree)(caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set)(make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

; 2.63 中序遍历将树转化为列表
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list tree)
  (define (copy-to-list tree result)
    (if (null? tree)
        result
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result)))))
  (copy-to-list tree '()))

; 2.64 将列表构造为平衡二叉树

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elements n)
  (if (= n 0)
      (cons '() elements)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elements left-size)))
          (let ((left-tree (car left-result))
                (non-left-elements (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elements))
                  (right-result (partial-tree (cdr non-left-elements)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elements (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)                                
                      remaining-elements))))))))


(define (intersection-list set1 set2)
  (if (or (null? set1)(null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-list (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-list (cdr set1) set2))
              ((< x2 x1)
               (intersection-list set1 (cdr set2)))))))

(define (intersection-tree tree1 tree2)
  (list->tree
   (intersection-list (tree->list tree1)
                      (tree->list tree2))))


(define (union-list set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2)))
           (cond ((= x1 x2)
                  (cons x1
                        (union-list (cdr set1)
                                    (cdr set2))))
                 ((< x1 x2)
                  (cons x1
                        (union-list (cdr set1)
                                    set2)))
                 ((< x2 x1)
                  (cons x2
                        (union-list set1
                                    (cdr set2)))))))))
(define (union-tree tree1 tree2)
  (list->tree
   (union-list (tree->list tree1)
               (tree->list tree2))))
                                       
(define b (partial-tree '(1 3 5 7 9) 5))                  
              
(define a (list->tree '(1 3 5 7 9)))
;(display b)
;(display "newline")
(display a)
;(display (tree->list a))
(define c (list->tree '(2 4 6 8)))
(define d (list->tree '(4 5 7)))
(newline)
(display (union-tree a c))
(newline)
(display (intersection-tree a d))

