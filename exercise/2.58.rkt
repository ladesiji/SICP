#lang planet neil/sicp
#|
扩充例题2.3.2 将幂的求导规则也加进来
符号求导

1、先定义求导算法,操作抽象对象
2、再定义具体对象的表示
|#

(define (deriv exp var)
  (cond
    ((number? exp) 0)
    ((variable? exp)
     (if (same-variable? exp var) 1 0))
    ((sum? exp)
     (make-sum
      (deriv (addend exp) var)
      (deriv (augend exp) var)))
    ((product? exp)
     (make-sum
      (make-product (multiplier exp)
                    (deriv (multiplicand exp) var))
      (make-product (multiplicand exp)
                    (deriv (multiplier exp) var))))
    (else
     (error "unknown expression type --DRIVE" exp))))

(define (variable? x) (symbol? x))
(define (same-variable? a b)
  (and (variable? a)(variable? b)(eq? a b)))
(define (=number? a b)
  (and (number? a)(= a b)))

(define (make-sum a b)
  (cond ((=number? a 0) b)
        ((=number? b 0) a)
        ((and (number? a)(number? b))
         (+ a b))
        (else
         (list a '+ b))))
(define (sum? x)
  (and (pair? x)
       (eq? (cadr x) '+)))
(define (addend x)
  (car x))
(define (augend x)
  (caddr x))

(define (make-product a b)
  (cond ((or (=number? a 0)(=number? b 0)) 0)
        ((and (number? a)(number? b)) (* a b))
        ((=number? a 1) b)
        ((=number? b 1) a)
        (else
         (list a '* b))))

(define (product? x)
  (and (pair? x)
       (eq? (cadr x) '*)))
(define (multiplier x)
  (car x))
(define (multiplicand x)
  (caddr x))
 
        
