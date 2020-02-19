#lang planet neil/sicp
#|
如何构造一颗 Huffman 树？
Huffman 树的表示
|#

; 构造叶节点和叶选择函数
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x)(cadr x))

(define (weight-leaf x)(caddr x))

; 构造树和节点选择函数
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left)(symbols right))
        (+ (weight left)(weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree)(cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

; 解码过程

(define (decode bits tree)
  (define (decode-r bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-r (cdr bits) tree))
              (decode-r (cdr bits) next-branch)))))
  (decode-r bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

; 带权重元素的集合
; 算法需要反复合并集合中最小的项，采用有序的表来表示集合，按升序排列

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else
         (cons (car set)
               (adjoin-set x (cdr set))))))


; 以符号-权重对偶的表为参数，构造树叶初始集合,用升序的表来表示，方便Huffman算法做归并
; in:((A 4)(B 2)(C 1)(D 1)) out: ((leaf d 1) (leaf c 1) (leaf b 2) (leaf a 4))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))


; test

(define leaf-set-a (make-leaf-set '((A 4)(B 2)(C 1)(D 1))))
(display leaf-set-a)

; 定义一棵编码树和一个样例消息

(define sample-tree
  (make-code-tree (make-leaf 'a 4)
                  (make-code-tree
                   (make-leaf 'b 2)
                   (make-code-tree
                    (make-leaf 'd 1)
                    (make-leaf 'c 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(newline)
(display sample-tree)
(newline)
(display (decode sample-message sample-tree))