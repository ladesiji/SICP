#lang planet neil/sicp

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree))(* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-m tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-m sub-tree)
             (* sub-tree sub-tree)))
       tree))

(define x (list (list (list 1 2) 3 4) (list 5 6)))

(square-tree x)
(square-tree-m x)