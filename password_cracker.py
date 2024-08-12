#!/usr/bin/python3

import crypt

def testPass(cryptPass):
    salt = cryptPass[0:2]
    with open('dictionary.txt', 'r') as dictFile:
        for word in dictFile:
            word = word.strip()
            cryptWord = crypt.crypt(word, salt)
            if cryptWord == cryptPass:
                print(f'[+] Found Password: {word}\n')
                return
    print('[-] Password Not Found.\n')
    return

def main():
    with open('passwords.txt') as passFile:
        for line in passFile:
            if ':' in line:
                user, cryptPass = line.split(':')[0], line.split(':')[1].strip()
                print(f'[*] Cracking Password For: {user}')
                testPass(cryptPass)

if __name__ == '__main__':
    main()
