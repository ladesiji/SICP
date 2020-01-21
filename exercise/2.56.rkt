#lang planet neil/sicp
#|
扩充例题2.3.2 将幂的求导规则也加进来

符号求导
1、先定义求导算法,操作抽象对象
2、再定义具体对象的表示
|#

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
          (make-product (multiplicand exp)
                        (deriv (multiplier exp) var))))
        ((power? exp)
         (make-product
          (make-product (power-n exp)
                        (make-power (power-u)(- (power-n exp) 1)))
          (deriv (power-u) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))
(define (same-variable? a b)
  (and (variable? a)(variable? b)(eq? a b)))
(define (make-sum a b)
  (cond ((=number? a 0) 0)
        ((=number? b 0) 0)
        ((and (number? a)(number? b))(+ a b))
        (else (list '+ a b))))
(define (make-product a b)
  (cond ((or (=number? a 0)(=number? b 0)) 0)
        ((=number? a 1) b)
        ((=number? b 1) a)
        (else (list '* a b))))
(define (make-power a b)
  (cond ((=number? b 0) 1)
        ((=number? b 1) a)
        (else (list '** a b))))
(define (sum? x)
  (and (pair? x)(eq? (car x) '+)))
(define (product? x)
  (and (pair? x)(eq? (car x) '*)))
(define (power? x)
  (and (pair? x)(eq? (car x) '**)))
(define (addend s)(cadr s))
(define (augend s)(caddr s))
(define (multiplier s)(cadr s))
(define (multiplicand s)(caddr s))

(define (power-u s)(cadr s))
(define (power-n s)(caddr s))

(define (=number? a b)
  (and (number? a)(= a b)))