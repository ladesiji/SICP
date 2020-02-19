#lang planet neil/sicp

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

; 以符号对偶表为参数, 生成Huffman树
; ((A 4)(B 2)(C 1)(D 1))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pair)))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (successive-merge leaf-set)
  
                    