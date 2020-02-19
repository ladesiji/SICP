#lang planet neil/sicp

; 完成 encode 过程，以 消息和树为参数，产生被编码消息对应的二进制位表

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((symbol-in-tree? symbol (left-branch tree))
         (cons 0
               (encode-symbol symbol (left-branch tree))))
        ((symbol-in-tree? symbol (right-branch tree))
         (cons 1
               (encode-symbol symbol (right-branch tree))))
        (else
         (error "This symbol not in tree: " symbol))))


(define (symbol-in-tree? given-symbol tree)
  (define (symbol-in-set symbol set)
    (cond ((null? set) false)
          ((eq? symbol (car set)) true)
          (else (symbol-in-set symbol (cdr set)))))
  (symbol-in-set given-symbol (symbols tree)))

; 将课本中的代码抄录如下:

; 构造叶节点和选择函数

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
 (eq? 'leaf (car object)))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

; 构造树 和选择函数

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

; 解码过程

(define (decode bits tree)
  (define (decode-r bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-r (cdr bits) tree))
              (decode-r (cdr bits) next-branch)))))
  (decode-r bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else
         (error "bad bit -- CHOOSE-BRANCH" bit))))

; 定义一棵编码树和一个样例消息
; 先将题目中代码抄录下来:
(define sample-tree
  (make-code-tree (make-leaf 'a 4)
                  (make-code-tree
                   (make-leaf 'b 2)
                   (make-code-tree
                    (make-leaf 'd 1)
                    (make-leaf 'c 1)))))

(define sample-message
  '(0 1 1 0 0 1 0 1 0 1 1 1 0))

; 开始解码

(define a (decode sample-message sample-tree))
(display a)
       
       