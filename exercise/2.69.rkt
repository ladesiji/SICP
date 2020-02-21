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
  (successive-merge (make-leaf-set pairs)))

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


#|
因为 successive-merge 接受的是有序集合(按权重值从低到高排列,用一个列表表示),所以我们可以这样来生成 Huffman 树:

1.如果集合的大小为 0 ,那么返回空表 '()
2.如果集合的大小为 1 ,那么返回列表的 car 部分,也即是,取出列表中(已经生成完毕)的 Huffman 树
3.如果集合的大小大于 1 ,也即是说,集合中至少有两个元素,那么根据集合已排序的原则,列表最前面的两个元素肯定是集合所有元素中权重最少的两个,因此,调用 make-code-tree 组合起这两个元素,得出新子树,并从表示集合的列表中删除这两个元素,得出新集合,然后使用函数 adjoin-tree ,将新子树有序地加入到新集合中去
4.一直进行步骤 3 ,直到落入步骤 2 为止
以上步骤最重要的就是使用 adjoin-tree 保持新列表也是有序的,所以组合树的操作可以继续有序地进行。

另外要指出的一点是,当 successive-merge 第一次被调用时,它接受的列表中的所有元素都是树叶,但是之后这个列表里就既有树叶,也有树了,因为我们使用通用的 weight 提取它们的权重,所以不会遇到列表中有两类元素需要处理的麻烦,这也体现了通用操作的威力。
|#

(define (successive-merge ordered-set)
  (cond ((= 0 (length ordered-set)) '())
        ((= 1 (length ordered-set))
         (car ordered-set))
        (else
         (let ((new-sub-tree (make-code-tree (car ordered-set)
                                             (cadr ordered-set)))
               (remained-ordered-set (cddr ordered-set)))
           (successive-merge (adjoin-set new-sub-tree remained-ordered-set))))))

; test
(define new-tree (generate-huffman-tree '((A 4)(B 2)(C 1)(D 1))))
(display new-tree)
  
                    