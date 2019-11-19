#lang planet neil/sicp
; last-pair,
; (last-pair (list 23 72 149 34)) == 34 

(define (last-pair items)
  (if (null? (cdr items))
      (car items)
      (last-pair (cdr items))))

(last-pair (list 24 72 149 34))