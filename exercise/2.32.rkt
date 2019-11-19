#lang planet neil/sicp
; 对于一个集合的所有子集的集合,可以分为两部分,含有第一个元素和不含第一个元素的集合
; 使用append 方法将这两部分加起来，就是所有子集
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
                            (cons (car s) x))
                          rest)))))

(subsets (list 1 2 3))

(define (subset s)
  (if (null? s)
      (list nil)
      (append (subset (cdr s))
              (map (lambda (x)(cons (car s) x))
                   (subset (cdr s))))))

(subset (list 1 2))