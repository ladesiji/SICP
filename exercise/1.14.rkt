#lang planet neil/sicp
; 自已实现零钱兑换 以第五套人民币为例
; 第五套人民币有 1元 5元 10元 20元 50元 100元 6种面额

(define (count-change n)
  (define (cc n kinds-of-rmb)
    (cond ((= n 0) 1)
          ((or (< n 0) (= kinds-of-rmb 0)) 0)
          (else (+ (cc n (- kinds-of-rmb 1))
                   (cc (- n
                        (values kinds-of-rmb))
                     kinds-of-rmb)))))

  (define (values kinds-of-rmb)
    (cond ((= kinds-of-rmb 1) 1)
          ((= kinds-of-rmb 2) 5)
          ((= kinds-of-rmb 3) 10)
          ((= kinds-of-rmb 4) 20)
          ((= kinds-of-rmb 5) 50)
          ((= kinds-of-rmb 6) 100)))
  (cc n 6))


                   