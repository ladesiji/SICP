#lang planet neil/sicp

(define right-split (split beside below))
(define up-split (split below beside))

(define (split big small)
  (lambda (painter n)
         (if (= n 0)
             painter
             (let ((smaller ((split big small) painter (- n 1))))
               (big painter
                    (small smaller smaller))))))