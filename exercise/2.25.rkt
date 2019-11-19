#lang planet neil/sicp
(define a '(1 3 (5 7) 9))
(define b '((7)))
(define c '(1 (2 (3 (4 (5 (6 7)))))))


(car (cdaddr a))
(caar b)
(cadadr (cadadr (cadadr c)))
