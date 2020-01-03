#lang planet neil/sicp

(define (make-segement start end)
  (list start end))

(define (start-segement seg)
  (car seg))
(define (end-segement seg)
  (cadr seg))

