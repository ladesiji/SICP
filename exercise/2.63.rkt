#lang planet neil/sicp

; 2.63
; a)判断两种方法是否相同
; b)算法复杂度是不相同

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

#|
a) 这两个方法都一样，都是中序遍历，按左树、根节点、右树的顺序来遍历每个节点。
b) 复杂度分析 tree->list-1 是 O(N2) 而 tree->list-2 是 O(N)
   原因在于，第一种方法对每个节点 进行一次 append 一次 cons
   第二种方法对每个节点进行一次 cons
   其中 append 方法本来的复杂度是 O(N) 而 cons 的复杂度是O(1).
   这是这两种方法的主要区别。
|#