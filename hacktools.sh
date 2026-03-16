#!/bin/bash
# cybsec/hacking tools
sudo apt install -y tor
sudo apt install -y torsocks 
sudo apt install -y proxychains
sudo apt install -y mitmproxy
sudo apt install -y nmap
sudo apt install -y net-tools
sudo apt install -y tcpdump
sudo apt install -y wireshark
sudo apt install -y hydra
sudo apt install -y hashcat
sudo apt install -y john
sudo apt install -y aircrack-ng
sudo apt install -y sqlmap
sudo apt install -y burpsuite
sudo apt install -y zaproxy
sudo apt install -y nikto
sudo apt install -y metasploit-framework
sudo apt install -y wpscan
go install github.com/ffuf/ffuf@latest
go install github.com/tomnomnom/httprobe@latest
go install github.com/jaeles-project/gau@latest
go install github.com/owasp-amass/amass/v3/...@latest

