#lang planet neil/sicp
; 将一些表操作看作累积的定义

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
#|
(define (map proc sequence)
  (if (null? sequence)
      nil
      (cons (proc (car sequence))
            (map proc (cdr sequence)))))
|#

(define (map p sequence)
  (accumulate (lambda (x y)(cons (p x) y))
              nil
              sequence))
#|
(define (append seq1 seq2)
  (if (null? seq1)
      seq2
      (cons (car seq1)
            (append (cdr seq1) seq2))))
|#

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

#|
(define (length sequence)
  (if (null? sequence)
      0
      (+ 1 (length (cdr sequence)))))
|#

(define (length sequence)
  (accumulate (lambda (x y)(+ 1 y)) 0 sequence))

