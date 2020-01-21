#lang planet neil/sicp
; 实现元素可重复的集合

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)(cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1)(null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (cond ((and (null? set1)(null? set2)) '())
        ((null? set1) set2)
        (else
         (cons (car set1)
               (union-set (cdr set1) set2)))))
(define (union set1 set2)
  (append set1 set2))
(define a '(1 2 3 4 5))
(define b '(3 4 5 6 7))
(define c (union-set a b))
(display c)
(define d (union a b))
(display d)