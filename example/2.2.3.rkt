#lang planet neil/sicp
; 2.23, 约定的界面

; 例题1 对一颗树的 奇的叶子求平方和
(define (sum-odd-square tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree)
             (* tree tree)
             0))
        (else (+ (sum-odd-square (car tree))
                 (sum-odd-square (cdr tree))))))


(define x (list 1 2 (list 3 (list 4 5) 6) 7))
(sum-odd-square x)

; 例题2 将所有是偶数的斐波那契数Fib(k) 构造成一个表
(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

; fib 递归过程
(define (fib-r k)
  (cond ((= k 0) 0)
        ((= k 1) 1)
        (else (+ (fib-r (- k 1))
                 (fib-r (- k 2))))))

; fib 迭代过程
(define (fib k)
  (define (fib-iter a b count)
    (if (= count 0)
        a
        (fib-iter b (+ a b) (- count 1))))
  (fib-iter 0 1 k))

(even-fibs 6)

; 按照 enumerate filter map accumulate 这个顺序，将计算的过程模块化。

; map 过程
(define (map proc sequence)
  (if (null? sequence)
      nil
      (cons (proc (car sequence))
            (map proc (cdr sequence)))))

; filter 过程
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
(filter odd? (list 1 2 3 4 5 6))

; accumulate 过程
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))

; enumerate-tree 和 enumerate-fib
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(enumerate-tree (list 1 2 (list 3 4 (list 5 6) 7) 8))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 2 7)

(define (enumerate-fib k)
  (map fib (enumerate-interval 0 k)))
(enumerate-fib 6)

; 重新构造sum-odd-squares 使用enumerate -> filter -> map -> accumurate 顺序

(define (sum-odd-squares-new tree)
  (accumulate +
              0
              (map (lambda(x)(* x x))
                   (filter odd?
                           (enumerate-tree tree)))))

; 重新构造 even-fibs 使用模块
(define (even-fibs-new k)
  (accumulate cons
              nil
              (filter even?
                      (map fib
                           (enumerate-interval 0 k)))))

; 构造 list-fib-squares
(define (list-fib-squares k)
  (accumulate cons
              nil
              (map (lambda (x)
                     (* x x))
                   (map fib
                        (enumerate-interval 0 k)))))
; 构造 序列中奇数的平方之积
(define (product-of-squares-of-odd-elements squence)
  (accumulate *
              1
              (map (lambda (x)(* x x))
                   (filter odd? squence))))


       