#lang planet neil/sicp
#|
符号求导
1、先定义求导算法，操作抽象对象
2、再定义具体对象的表示
|#

; 对抽象数据的求导程序

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

; 代数表达式的表示，设计选择函数和构造函数

(define (variable? x)(symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)(variable? v2)(eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1)(number? a2))(+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0)(=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        (else (list '* m1 m2))))

(define (sum? x)
  (and (pair? x)(eq? (car x) '+)))

(define (addend s)(cadr s))
(define (augend s)(caddr s))

(define (product? x)
  (and (pair? x)(eq? (car x) '*)))

(define (multiplier p)(cadr p))
(define (multiplicand p)(caddr p))

(define (=number? exp num)
  (and (number? exp)(= exp num)))