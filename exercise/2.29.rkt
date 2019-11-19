#lang planet neil/sicp
; 二叉活动体
; 有两个分支组成，左分支和右分支，每个分支是一个确定长度的杆，加一下重量或一个二叉结构体。

; 构造结构体
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a) 结构体的基本方法
(define (left-branch structure)
  (car structure))

;(define (right-branch structure)
;  (cadr structure))

(define (branch-length branch)
  (car branch))

;(define (branch-structure branch)
;  (cadr branch))

; b) 求结构体的重量
(define (total-weight structure)
  (if (not (pair? structure))
      structure
      (+ (total-weight (branch-structure (left-branch structure)))
         (total-weight (branch-structure (right-branch structure))))))

; c) 一个活动体是平衡的，那么也左树的力矩乘以重量，与右树相同，且所有子树也是平衡的。
(define (balance? structure)
  (if (not (pair? structure))
      #t
      (if (not (= (* (branch-length (left-branch structure))
                     (total-weight (branch-structure (left-branch structure))))
                  (* (branch-length (right-branch structure))
                     (total-weight (branch-structure (right-branch structure))))))
          #f
          (and (balance? (branch-structure (left-branch structure)))
               (balance? (branch-structure (right-branch structure)))))))
     
; d)使用cons代替list 来构造活动体
(define (make-mobile-n left right)
  (cons left right))
(define (make-branch-n length structure)
  (cons length structure))
(define (right-branch structure)
  (cdr structure))
(define (branch-structure branch)
  (cdr branch))

(define a (cons (cons 2 6) (cons 4 2)))
(define b (cons (cons 3 a) (cons 3 8)))