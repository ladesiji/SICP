#lang planet neil/sicp
; count-change 1.22
; 将现金a换成除第一种硬币之外的所有其他硬币的不同方式，加上
; 将现金数a-d换成所有种类的硬币的不同方式，其中d是第一种硬币的币值

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)

; 使用list更新上述程序中涉及币种信息的first-denomination 和 kinds-of-coins

(define us-coins (list 50 25 10 1 5))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (new-cc amount coin-values)
  (cond ((= amount 0) 1)
        (( or (< amount 0) (null? coin-values)) 0)
        (else
         (+ (new-cc amount
                    (cdr coin-values))
            (new-cc (- amount
                       (car coin-values))
                    coin-values)))))

(new-cc 100 us-coins)
(new-cc 100 uk-coins)