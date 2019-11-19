#lang planet neil/sicp
; reverse
; (reverse (list 1 2 3 4)) == (list 4 3 2 1)
(define (reverse items)
  (if (null? (cdr items))
      items
      (append (reverse (cdr items))
              (list (car items)))))

(define (reverse-c items)
  (if (null? (cdr items))
      (car items)
      (cons (reverse-c (cdr items))
            (car items))))
             

(define aa (list 1 2 3 4))
(reverse aa)
(reverse-c aa)