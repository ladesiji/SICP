#lang planet neil/sicp
; 汉诺塔
; 有三个柱子， 分别为from to space，
; 现在from 上有64个大小不一的盘子，按大的在下小的在上的顺序叠在柱子上。
; 移动的规则上每次只能移动一个盘子，且小盘子必须在大的盘子上面。
; 问 如何实现将 64个盘子 从from 移动到 to。


(define (hanoi n from to buffer)
 (if (= n 1)
  (list (cons from to))
  (append
   (hanoi (- n 1) from buffer to)
   (hanoi 1 from to buffer)
   (hanoi (- n 1) buffer to from))))
      
      
      