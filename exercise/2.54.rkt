#lang planet neil/sicp


(define (equal? list1 list2)
  (cond ((and (null? list1)(null? list2)) true)
        ((and (not (null? list1))(not (null? list2)))
         (if (eq? (car list1)(car list2))
             (equal? (cdr list1)(cdr list2))
             false))
        (else false)))
        