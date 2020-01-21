#lang planet neil/sicp
#|

实现set 的四个操作
intersection-set
element-of-set?
adjion-set
union-set

|#

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjion-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1)(null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))
        
(define (union-set set1 set2)
  (cond ((and (null? set1)(null? set2)) '())
        ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else
         (cons (cdr set1)
               (union-set (cdr set1) set2)))))

(define a '( 1 2 3 4 5 6 7 8))
(element-of-set? 4 a)
(element-of-set? 9 a)
(define b (adjion-set 9 a))
(element-of-set? 9 b)
(define c (intersection-set a b))
(display c)
(define d (union-set a b))
(display d)