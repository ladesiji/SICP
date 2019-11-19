#lang planet neil/sicp
; 任意个实际参数


(define (same-parity first-arg . other-args)
  (filter (if (even? first-arg)
              even?
              odd?)
          (cons first-arg other-args)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7 8)


  