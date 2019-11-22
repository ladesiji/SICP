#lang planet neil/sicp
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
#|
(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))
|#
(define x (list 1 2 (list 3 4 (list 5 6) 7) 8))


(define (map proc sequence)
  (if (null? sequence)
      nil
      (cons (proc (car sequence))
            (map proc (cdr sequence)))))

(define (map-tree proc tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (proc tree))
        (else (cons (map-tree proc (car tree))
                    (map-tree proc (cdr tree))))))

(map-tree (lambda(x)(+ 1 x)) x)

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(enumerate-tree x)
#|
当 map 在遍历树的时候,它会遇到两种情况:
1、节点是叶子节点,如果是这样的话,那么返回 1 ,作为这个节点的树叶数量。
2、节点有左右两个分支,那么这个节点的树叶数量就是这个节点调用 count-leaves 函数的结果。
(define (count-leaves tree)
  (accumulate <?> <?> (map <?> <?>))
|#
(define (count-leaves tree)
  (accumulate + 0 (map (lambda(x)
                         (if (pair? x)
                             (count-leaves x)
                             1))
                       tree)))
