#lang br/quicklang
(provide + *)

(define-macro (stackerizer-mb EXPR)
  #'(#%module-begin
    (for-each displayln (reverse (flatten EXPR)))))
(provide (rename-out [stackerizer-mb #%module-begin]))

(define-macro (define-op OP)
    #'(define-macro-cases OP
        [(OP FIRST) #'FIRST]
        [(OP FIRST NEXT (... ...)) #'(list 'OP FIRST (OP NEXT (... ...)))]
    )
)

(define-macro (define-ops OP ...)
    #'(begin                                            ;
    (define-macro-cases OP                              ;
        [(OP FIRST) #'FIRST]                            ;
        [(OP FIRST NEXT (... ...))                      ;
            #'(list 'OP FIRST (OP NEXT (... ...)))])    ; (... ...) is because we want ellipses in the inner macro, not the outer
        ...                                             ; The ... operator uses preceding arg as a template
    )
)

(define-ops + *)