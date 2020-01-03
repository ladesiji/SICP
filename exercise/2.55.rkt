#lang planet neil/sicp
#|
符号 ' 在求值时会被替换成 quote 特殊形式,因此,求值:

(car ''abracadabra)
实际上就是求值:

(car '(quote abracadabra))
因此 car 取出的是第一个 quote 的 car 部分,而这个 car 部分就是 'quote ,所以返回值就是 quote :



|#

(car ''abracadabra)

;Value: quote