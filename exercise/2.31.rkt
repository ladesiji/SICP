#lang planet neil/sicp
(define (square-tree tree)
  (tree-map square tree))

(define (square x)
  (* x x))

(define (tree-map proc tree)
  (cond ((null? tree) nil)
        ((not (pair? tree))(proc tree))
        (else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree))))))

(define x (list 1 2 (list 3 4 (list 5 6) 7) 8))

(square-tree x)