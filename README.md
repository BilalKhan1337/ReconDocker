# Automated Domain Scanner

This repository contains a Dockerized environment that automatically scans a domain using various security tools. It is designed to perform subdomain enumeration, port scanning, vulnerability detection, and web application security testing, all within a Docker container.

## Tools Included
- **Amass**: Subdomain enumeration.
- **Subfinder**: Subdomain enumeration.
- **Nmap**: Port scanning.
- **Nuclei**: Template-based vulnerability scanning.
- **OWASP ZAP**: Web application vulnerability scanning.

## How to Use

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/BilalKhan1337/ReconDocker.git
cd ReconDocker
docker build -t domain-scanner .
docker run -v $(pwd)/results:/app/results domain-scanner example.com

```





## Example Command
- docker run -v $(pwd)/results:/app/results domain-scanner example.com


