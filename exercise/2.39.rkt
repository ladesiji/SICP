#lang planet neil/sicp
; 使用 fold-left 和 fold-right 完成 reverse 操作

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))


(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverse sequence)
  (if (null? (cdr sequence))
      sequence
      (append (reverse (cdr sequence))
              (list (car sequence)))))

(define (reverse-fl sequence)
  (fold-left (lambda(x y)(cons y x))
             nil
             sequence))

(define (reverse-fr sequence)
  (fold-right (lambda(x y)
                (append y (list x)))
              nil
              sequence))

                            