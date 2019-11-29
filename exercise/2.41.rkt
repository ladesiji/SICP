#lang planet neil/sicp

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low
            (enumerate-interval (+ low 1)
                                high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc sequence)
  (accumulate append
              nil
              (map proc sequence)))

(define (three-pair n)
  (flatmap (lambda(i)
             (map (lambda(j)
                    (map (lambda(k)(list k j i))
                         (enumerate-interval 1 j)))
                  (enumerate-interval 1 i)))
           (enumerate-interval 1 n)))
(define (three-pairs n)
  (accumulate append
              nil
              (accumulate append
                          nil
                          (map (lambda(i)
                                 (map (lambda(j)
                                        (map (lambda(k)(list i j k))
                                             (enumerate-interval 1 (- j 1))))
                                      (enumerate-interval 1 (- i 1))))
                               (enumerate-interval 1 n)))))
                                        
                               

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else
         (filter predicate (cdr sequence)))))


(define (pairs-sum? pair s)
  (= (+ (car pair)
        (cadr pair)
        (caddr pair))
     s))

(define (make-pairs-sum n s)
  (define (pairs-sum? pair)
    (= (+ (car pair)
          (cadr pair)
          (caddr pair))
       s))
  (filter pairs-sum?
          (three-pairs n)))
