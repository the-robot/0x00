import dns.zone
import dns.resolver
import sys

def xfer(address):
    ns_answer = dns.resolver.resolve(address, 'NS')

    for server in ns_answer:
        print(f"[*] Found NS: {server}")
        ip_answer = dns.resolver.resolve(server.target, 'A')
        
        for ip in ip_answer:
            print(f"[*] {server}: {ip}")
            try:
                zone = dns.zone.from_xfr(dns.query.xfr(str(ip), address))
                for host in zone:
                    print(f"[+] Found Host: {host}")
            except:
                print(f"[-] NS {server} refused zone transfer")
                continue

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("zonetransfer.py [domain]")
        sys.exit(1)

    xfer(sys.argv[1])
