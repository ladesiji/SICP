#lang planet neil/sicp
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))

(define (lookup-tree given-key tree-of-records)
  (if (null? tree-of-records)
      false
      (let ((x (key (entry tree-of-records))))
        (cond ((= x given-key)
               (entry (tree-of-records)))
              ((< given-key x)
               (lookup-tree given-key (left-branch tree-of-records)))
              ((< x given-key)
               (lookup-tree given-key (right-branch tree-of-records)))))))

(define (entry tree)(car tree))
(define (left-branch tree)(cadr tree))
(define (right-branch tree)(caddr tree))
(define (key node)(car node))