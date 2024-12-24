#lang br
(require jsonic/jsonic-parser jsonic/jsonic-tokenizer brag/support)

(parse-to-datum (apply-tokenizer-maker make-tokenizer "@$ 42 $@"))