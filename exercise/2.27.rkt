#lang planet neil/sicp
(define (reverse items)
  (if (null? (cdr items))
      items
      (append (reverse (cdr items))
              (list (car items)))))

; 只适用于叉树情形
(define (deep-reverse tree)
  (cond ((null? tree)
         '())
        ((not (pair? tree))
         tree)
        (else
         (reverse (list (deep-reverse (car tree))
                        (deep-reverse (cadr tree)))))))

; 适用于所有树形的反转
(define (tree-reverse tree)
  (define (iter remained-items result)
    (if (null? remained-items)
        result
        (iter (cdr remained-items)
              (cons (if (pair? (car remained-items))
                        (tree-reverse (car remained-items))
                        (car remained-items))
                    result))))
  (iter tree '()))

(define aa (list (list 1 2)(list 3 4)))
(define bb (list (list 1 2)(list 3 4)(list 5 6)))
(deep-reverse aa)
(tree-reverse bb)