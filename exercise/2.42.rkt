#lang planet neil/sicp
#| 八皇后谜题
怎样将八个皇后摆在棋盘上，使得任意一个皇后不能攻击另一个皇后，
也就是说，任意两个皇后都不在同一行、同一列、同一对角线上。
解题方法：
按一个方向处理棋盘，每次在每一列里放一个皇后。如果现在已经放好了k-1个皇后，
第k个皇后就必须放在不会被已在棋盘上的任何皇后攻击的位置上。
我们可以用递归描述这一过程，假定我们已经生成了在棋盘的前k-1列中放置k-1个皇后的所有可能方式
现在需要的就是对其中的每种方式行成出将下一个皇后放在第k列中每一行的扩充集合，而后过滤它们，
只留下能使位于第k列的皇后与其他相安无事的那些扩充。这样就能产生出将k个皇后放置在前k列的所有格局的序列。
继续这一过程，我们将能产生出这一谜题的所有解，而不是一个解。
|#

; 主程序
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions)(safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; 定义-empty-board
(define empty-board nil)

; adjoin-position
(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

; safe?
(define (safe? k position)
  (iter-check (car position)
              (cdr position)
              1))
(define (iter-check row-of-new-queen rest-of-queens i)
  (if (null? rest-of-queens) ;下方所有皇后检查完毕，新皇后安全
      true
      (let ((row-of-current-queen (car rest-of-queens)))
        (if (or (= row-of-new-queen row-of-current-queen)
                (= row-of-new-queen (+ row-of-current-queen i))
                (= row-of-new-queen (- row-of-current-queen i)))
            false
            (iter-check row-of-new-queen
                        (cdr rest-of-queens)
                        (+ i 1))))))
            

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      nil
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc sequence)
  (accumulate append
              nil
              (map proc sequence)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else
         (filter predicate (cdr sequence)))))
            
