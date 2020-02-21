;#lang planet neil/sicp
#lang sicp
; 构造 叶节点 与 选择函数

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? 'leaf (car object)))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

; 构造 树 与 选择函数

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left)
                (symbols right))
        (+ (weight left)
           (weight right))))

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
        (let ((next-branch (choose-branch (car bits)
                                          current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-r (cdr bits) tree))
              (decode-r (cdr bits) next-branch)))))
  (decode-r bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

; 带权重的有序集合添加元素

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))


; encode 过程

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
        (else (error "This symbol not in tree" symbol))))

(define (symbol-in-tree? symbol tree)
  (define (symbol-in-set? symbol set)
    (cond ((null? set) false)
          ((eq? symbol (car set)) true)
          (else (symbol-in-set? symbol (cdr set)))))
  (symbol-in-set? symbol (symbols tree)))



; 根据符号-频率对偶表 生成 Huffman 树

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-set)
  (cond ((= 0 (length ordered-set)) '())
        ((= 1 (length ordered-set))
         (car ordered-set))
        (else
         (let ((new-sub-tree (make-code-tree (car ordered-set)
                                             (cadr ordered-set)))
               (remained-ordered-set (cddr ordered-set)))
           (successive-merge (adjoin-set new-sub-tree remained-ordered-set))))))



; 2-70 将歌词生成编码

(define tree
  (generate-huffman-tree '((a 1) (na 16) (boom 1) (sha 3) (get 2) (yip 9) (job 2) (wah 1))))

(define msg-1 '(get a job))
(define msg-2 '(sha na na na na na na na na))
(define msg-3 '(wah yip yip yip yip yip yip yip yip yip))
(define msg-4 '(sha boom))

(define c-1 (encode msg-1 tree))
(define c-2 (encode msg-2 tree))
(define c-3 (encode msg-3 tree))
(define c-4 (encode msg-4 tree))

(define huffman-code-length
 (+ (* (+ (length c-1)(length c-2)) 2)
    (length c-3)
    (length c-4)))

(define normal-code-length
 (* (+ (* (+ (length msg-1)(length msg-2)) 2)
       (length msg-3)
       (length msg-4))
    3))

huffman-code-length
normal-code-length
