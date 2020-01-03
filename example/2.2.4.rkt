#lang planet neil/sicp
; 递归完成图片的分割

; 向右
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

; 向上
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

; 拐角
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (smaller (corner-split painter (- n 1))))
        (below (beside painter (below (right right)))
               (beside (beside up up) smaller)))))
; 四角变幻
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter)(tr painter)))
          (bottom (beside (bl painter)(br painter))))
      (below bottom top))))

; flipped-pairs
(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
                                 identity flip-vert)))
    (combine4 painter)))
;square-limit
(define (square-limit painter n)
  (let ((combin4 (square-of-four flip-horiz identity
                                 rotate180 flip-vert)))
    (combin4 (corner-split painter n))))

            