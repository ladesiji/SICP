#lang planet neil/sicp
; 描述下面过程的行为
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b)) ; 如果b为正 则加上b b为负，减去b。

