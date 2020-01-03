#lang planet neil/sicp

(define  (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)(start-segment segement))
        ((frame-coord-map frame)(end-segment segement))))
     segmen-list)))


; 定义向量
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

; 定义线段
(define (make-segement start end)
  (list start end))

(define (start-segement seg)
  (car seg))
(define (end-segement seg)
  (cadr seg))

; 定义框架画家
; 先定义四个顶点向量
(define top-left (make-vect 0.0 1.0))
(define top-right (make-vect 1.0 1.0))
(define bottom-left (make-vect 0.0 0.0))
(define bottom-right (make-vect 1.0 0.0))
; 再定义四条边
(define top (make-segement top-left top-right))
(define left (make-segement top-left bottom-left))
(define right (make-segement top-right bottom-right))
(define bottom (make-segement bottom-left bottom-right))



(segement->painter (list top bottom left right))