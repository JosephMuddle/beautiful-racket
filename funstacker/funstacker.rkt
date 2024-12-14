#lang br/quicklang

(define (read-syntax path port)
    (define src-lines (port->lines port))
    (define src-datums (format-datums '~a src-lines))
    (define module-datum `(module funstacker-mod "funstacker.rkt" 
                            (handle-args ,@src-datums)))
    (datum->syntax #f module-datum))

(provide read-syntax)

(define-macro (funstacker-module-begin HANDLE-ARGS-EXPR)
    #'(#%module-begin
        (display (first HANDLE-ARGS-EXPR))))
(provide (rename-out [funstacker-module-begin #%module-begin]))

(define (handle-args . args)
        (for/fold 
                ([acc-stack empty]) ;initialise accumulator with value
                ([arg (in-list args)] ;cycles thru these
                #:unless (void? arg)) ;guard condition
                (cond                                       ;beginning of for loop body
                    [(number? arg) (cons arg acc-stack)]
                    [(or (equal? * arg) (equal? + arg))
                        (define op-result
                            (arg (first acc-stack) (second acc-stack))
                        )
                        (cons op-result (drop acc-stack 2))
                    ]
                )
        )
)
(provide handle-args)
(provide + *)