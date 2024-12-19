#lang br/quicklang
(require "bf-parser.rkt")
(define (read-syntax path port)
    (define parse-tree (parse path (make-tokenizer port)))
    (define module-datum `(module bf-mod "bf-expander.rkt" ,parse-tree))
    (datum->syntax #f module-datum))
(provide read-syntax)

(require brag/support)
(define (make-tokenizer port)
    (define (next-token)
        (define bf-lexer
            (lexer
            [(char-set "><-.,+[]") lexeme]      ;This matches to one of the tokens in the string here, and returns that as
            [any-char (next-token)]))           ;lexeme which is a reserved word in terms of lexing
        (bf-lexer port))
    next-token)