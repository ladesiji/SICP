#lang planet neil/sicp
(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))


(define (square-list items)
  (if (null? items)
      nil
      (cons (* (car items) (car items))
            (square-list (cdr items)))))

(define (square-list-m items)
  (map (lambda(x)(* x x)) items))

(square-list (list 1 2 3 4 5))
(square-list-m (list 6 7 8 9 10))