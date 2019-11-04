;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "vanilla-reader.rkt" "deinprogramm" "sdp")((modname Fibonacci) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
;;; The fib procedure computes the fibonacci number
(define fib
  (lambda (n)
    (cond ((= n 1) 1)   ;Base case return 1
          ((= n 2) 1)   ;Base case return 1
          ((> n 2)
           (+ (fib (- n 2)) (fib (- n 1)))))))

(fib 20)
