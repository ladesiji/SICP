#lang planet neil/sicp
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1)(null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond
          ((= x1 x2)
           (cons x1
                 (intersection-set (cdr set1)
                                   (cdr set2))))
          ((< x1 x2)
           (intersection-set (cdr set1) set2))
          ((< x2 x1)
           (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set)
  (union-set (list x) set))
(define (adjoin x set)
  (if (null? set)
      (list x)
      (let ((current-element (car set))
            (remain-element (cdr set)))
        (cond
          ((= x current-element)
           set)
          ((< x current-element)
           (cons x set))
          ((> x current-element)
           (cons current-element
                 (adjoin x remain-element)))))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
              (x2 (car set2)))
          (cond
            ((= x1 x2)
             (cons x1 (union-set (cdr set1)
                                 (cdr set2))))
            ((< x1 x2)
             (cons x1 (union-set (cdr set1) set2)))
            ((> x1 x2)
             (cons x2 (union-set set1 (cdr set2)))))))))


(define a '(1 2 3 5 7))
(define b '(1 2 4 6 8))
(display (adjoin 6 a))
(display (adjoin-set 5 b))
(display (intersection-set a b))
(display (union-set a b))