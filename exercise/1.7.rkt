
#lang planet neil/sicp
; 改进 good-enough? 函数，监测猜测值变化过程，如果改进很小就认为很好。
; 采用牛顿法求平方根
; 牛顿法先有一个猜测值y 然后求y 与 x/y 的平均值,逐步逼近正确结果
; 根 = (y + x/y)/2 

(define (sqrt-iter guess x)    ; 递归函数
  (if (good-enough? guess x)   ; 判断猜测值是否足够好返回bool值
      guess                    ; 真 则返加猜测值
      (sqrt-iter               ; 假 则进行递归
       (improve guess x)       ; 改进猜测值
                 x)))

(define (improve guess x)      ; 牛顿法的改进函数
  (average guess (/ x guess)))

(define (average x y)          ; 求平均过程
  (/ (+ x y) 2))

;(define (good-enough? guess x) ; 猜测值的平方与 X 的差的绝对值在一个小范围内
;  (< (abs (- (square guess) x)) 0.0001))

(define (square x)             ; 求平方过程
  (* x x))

(define (sqrt x)               ; 封装过程,将初始猜测值设为1
  (sqrt-iter 1.0 x))

(define (good-enough? guess x)
  (< (abs (/ (- guess (improve guess x)) guess)) 0.001))