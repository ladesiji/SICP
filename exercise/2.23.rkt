#lang planet neil/sicp

(define (for-each proc items)
  (if (not (null? items))
      (begin
        (proc (car items))
        (for-each proc (cdr items)))))

(for-each (lambda(x)(newline)(display x)) (list 1 2 3 4))
(define a 10)
(for-each (lambda(x)(newline)(display (+ a 10))) (list 1 2 3 4))