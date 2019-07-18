#lang planet neil/sicp
; 找素数 并计时
; 网上找的答案，勉强看懂，不会写。

(define (smallest-divisor n)
  (define (square x) (* x x))
  (define (divides? a b) (= (remainder a b) 0))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? n test-divisor) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (find-divisor n 2))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (begin 
	(report-prime n (- (runtime) start-time))
	#t)
      #f))

(define (report-prime number elapsed-time)
  (display number)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (find-prime start end number)
  (if (even? start) 
      (find-prime (+ start 1) end number)
      (find-prime-iter start end 0 number)))

(define (find-prime-iter start end cur-number max-number)
  (if (and (< start end) (< cur-number max-number))
      (if (timed-prime-test start)
	  (find-prime-iter (+ start 2) end (+ 1 cur-number) max-number)
	  (find-prime-iter (+ start 2) end cur-number max-number))
      cur-number))

(find-prime 1 1000 100)
      