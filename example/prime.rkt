#lang planet neil/sicp

; 判断素数
(define (prime? n)
  (define (find-divisor test n)
    (cond ((> (* test test) n) n)
          ((= (remainder n test) 0) test)
          (else
           (find-divisor (next test) n))))
  (define (next x)
    (if (= x 2)
        3
        (+ x 2)))
  (= (find-divisor 2 n) n))

; 费马小定理 判断素数
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
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n)(fast-prime? n (- times 1)))
        (else false)))

  