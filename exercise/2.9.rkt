#lang planet neil/sicp
;;

; 对于加法
; [aL, aH] + [bL, bH] = [aL + bL, aH + bH].
;  width = 1/2 * ((aH + bH) - (aL + bL))
;        = 1/2 * ((aH - aL) + (bH - bL))
;        = width of interval a + width of interval b

; 对于乘法
;   [0, 10] * [0, 2] = [0, 20]   (width = 10)
;   [-5, 5] * [-1, 1] = [-5, 5]   (width = 5)