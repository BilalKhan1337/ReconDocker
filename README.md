# Automated Domain Scanner

This repository contains a Dockerized environment that automatically scans a domain using various security tools (Amass, Subfinder, Nmap, Nuclei, and OWASP ZAP).

## Tools Included:
- Amass (Subdomain Enumeration)
- Subfinder (Subdomain Enumeration)
- Nmap (Port Scanning)
- Nuclei (Vulnerability Scanning)
- OWASP ZAP (Web Application Scanning)

## How to Use

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/domain-scanner.git
cd domain-scanner
docker build -t domain-scanner .
docker run -v $(pwd)/results:/app/results domain-scanner example.com


