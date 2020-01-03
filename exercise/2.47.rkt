#lang planet neil/sicp
(define  (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1)
                (xcor-vect vect2))
             (+ (ycor-vect vect1)
                (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1)
                (xcor-vect vect2))
             (- (ycor-vect vect1)
                (ycor-vect vect2))))

(define (scale-vect s vect)
  (make-vect (* (xcor-vect vect)
                s)
             (* (ycor-vect vect)
                s)))

(define (make-frame origin edge1 edge2)
  (cons origin
        (cons edge1 edge2)))

(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (cadr f))
(define (edge2-frame f)
  (cddr f))
