#lang planet neil/sicp
; 有理数的计算，实现有理数的运算，包含正负数
; 当有理数为正时分子分母都是正的，当为负时，只让分子为负
; make-rat

(define (make-rat n d)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (let ((g (gcd (abs n) (abs d))))
    (if (> (* n d) 0)
        (cons (/ n g)(/ d g))
        (cons (/ (abs n) (- g))(/ (abs d) g)))))
; 返回分子
(define (numer x) (car x))
; 返加分母
(define (denom x) (cdr x))
; 打印有理数
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; 定义有理数的加减乘除
(define (add-rat x y)
  (make-rat (+ (* (numer x)(denom y))
               (* (numer y)(denom x)))
            (* (denom x)(denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x)(denom y))
               (* (numer y)(denom x)))
            (* (denom x)(denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x)(numer y))
            (* (denom x)(denom y))))

(define (div-rat x y)
  (make-rat (* (numer x)(denom y))
            (* (denom x)(numer y))))

(define (equal-rat? x y)
  (= (* (numer x)(denom y))
     (* (numer y)(denom x))))

(define a (make-rat 1 2))
(define b (make-rat 1 3))
a
b
(add-rat a b)
(sub-rat a b)
(mul-rat a b)
(div-rat a b)

