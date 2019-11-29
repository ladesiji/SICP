#lang planet neil/sicp
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (unique-pair n)
  (accumulate append
              nil
              (map (lambda(i)
                     (map (lambda(j)(list i j))
                          (enumerate-interval 1 (- i 1))))
                   (enumerate-interval 1 n))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (flatmap proc sequence)
  (accumulate append nil (map proc sequence)))

(define (unique-pairs n)
  (flatmap (lambda(i)
             (map (lambda(j)(list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else
         (filter predicate (cdr sequence)))))

(define (prime? n)
  (define (fast-prime? n times)
    (cond ((= times 0) true)
          ((fermat-test n)(fast-prime? n (- times 1)))
          (else false)))
  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))
  (define (square x)
    (* x x))
  (fast-prime? n 5))

(define (prime-sum-pairs n)
  (define (make-sum-pair pair)
    (let ((a (car pair))
          (b (cadr pair)))
      (list a b (+ a b))))
  (define (prime-sum? pair)
    (prime? (+ (car pair)
               (cadr pair))))
  (map make-sum-pair
       (filter prime-sum?
               (unique-pairs n))))

          