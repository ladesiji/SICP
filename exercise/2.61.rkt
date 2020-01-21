#lang planet neil/sicp
#|

采用 排序的列表来表示 集合

|#

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (car set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1)(null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))


(define (adjoin-set x set)
  (if (null? set)
      (list x)
      (let ((current-element (car set))
            (remain-element (cdr set)))
        (cond ((= x current-element)
               set)
              ((> x current-element)
               (cons current-element
                     (adjoin-set x remain-element)))
              ((< x current-element)
               (cons x set))))))

               