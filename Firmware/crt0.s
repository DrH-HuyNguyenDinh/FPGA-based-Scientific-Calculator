# crt0.s
.section .text.entry
.global _start

_start:
    .option push
    .option norelax
    la sp, _stack_ptr
    .option pop
    
    call main
_exit:
    j _exit
