from scapy.all import *


# source: https://stackoverflow.com/questions/28292224/scapy-packet-sniffer-triggering-an-action-up-on-each-sniffed-packet
def pkt_callback(pkt):
    print(pkt.sniffed_on+": "+pkt.summary())

sniff(iface="nf1", prn=pkt_callback, filter="host 10.1.1.202" , store=10, count=5)
