#!/usr/bin/python3

# ----------------------------------------------------
# Automated script to VRFY users of multiple machines.
# ----------------------------------------------------

import socket
import sys

if len(sys.argv) != 3:
    print "Usage: vrfy.py <machines.txt> <users.txt>"
    sys.exit(0)

def scan(ip, port, users):
    # Create a socket
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Connect to the server
    connect = s.connect((ip, port))

    # Receive the banner
    banner = s.recv(1024)
    print(banner.strip())

    # VRFY users
    for user in users:
        s.send('VRFY ' + user + '\r\n')
        result = s.recv(1024)
        print(result.strip())

    # Close the socket
    s.close()

def readfiles(filename):
    with open(filename, 'r') as f:
        return [x.rstrip() for x in f.readlines()]

if __name__ == '__main__':
    addresses = readfiles(sys.argv[1])
    users = readfiles(sys.argv[2])

    for address in addresses:
        ip = None
        port = 25 # default port
        
        address_split = address.split(" ")
        if len(address_split) == 0:
            print "[-] invalid address: %s" % (address)
            continue
        elif len(address_split) == 2:
            ip = address_split[0]
            port = int(address_split[1])
        else:
            ip = address_split[0]

        print "Scanning: %s:%s" % (ip, port)
        scan(ip, port, users)
        print "\n"
