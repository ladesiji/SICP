#lang planet neil/sicp
#|
分析 list->tree 过程
|#

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

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; test
(define a (list->tree '(1 3 5 7 9 11)))
(display a)

#|
a) 分析过程
(1 3)(5 7 9 11)             ; 分割左右子树

(5 7 9 11)                  ; 创建 1 节点
    /
   /
1(3)

   (5 7 9 11)               ; 创建 1 的左子树(空)
      /
     /
   1(3)
   /
  /
'()

    (5 7 9 11)              ; 创建 1 的右子树(包含 3)
      /
     /
    1
   / \
  /   \
'()    3

       5 (7 9 11)           ; 创建树根 5
      /
     /
    1
   / \
  /   \
'()    3

       5                    ; 创建 9 节点
      / \
     /   \
    1     9 (7 11)
   / \
  /   \
'()    3

         5                  ; 创建 9 的左子树(包含 7)
        /\
       /  \
      /    \
     /      \
    1        9 (11)
   / \      /
  /   \    /
'()    3  7

         5                  ; 创建 9 的右子树(包含 11)
        / \
       /   \
      /     \
     /       \
    1         9
   / \       / \
  /   \     /   \
'()    3   7    11


b)
对于列表中的每个节点, list->tree 都要执行一次 make-tree (复杂度为 Θ(1) ),
将这个节点和它的左右子树组合起来,因此对于长度为 n 的列表来说, list->tree 的复杂度为 Θ(n) 。

|#
                  