#!/bin/bash

# Check if domain is passed as an argument
if [ -z "$1" ]; then
  echo "Error: No domain provided."
  echo "Usage: ./scan.sh <domain>"
  exit 1
fi

DOMAIN=$1
SCAN_DIR="/app/results/$DOMAIN"
mkdir -p "$SCAN_DIR"

echo "Starting scan for domain: $DOMAIN"

# Subdomain enumeration using Amass
echo "Running Amass for subdomain enumeration..."
amass enum -d $DOMAIN -o "$SCAN_DIR/amass_subdomains.txt" || echo "Amass failed."

# Subdomain enumeration using Subfinder
echo "Running Subfinder for subdomain enumeration..."
subfinder -d $DOMAIN -o "$SCAN_DIR/subfinder_subdomains.txt" || echo "Subfinder failed."

# Merge and remove duplicates
cat "$SCAN_DIR/amass_subdomains.txt" "$SCAN_DIR/subfinder_subdomains.txt" | sort -u > "$SCAN_DIR/all_subdomains.txt"

if [ ! -s "$SCAN_DIR/all_subdomains.txt" ]; then
  echo "No subdomains found. Exiting."
  exit 1
fi

# Port scanning using Nmap
echo "Running Nmap for port scanning..."
nmap -Pn -p- -iL "$SCAN_DIR/all_subdomains.txt" -oN "$SCAN_DIR/nmap_results.txt" || echo "Nmap failed."

# Vulnerability scanning using Nuclei
echo "Running Nuclei for vulnerability scanning..."
nuclei -l "$SCAN_DIR/all_subdomains.txt" -o "$SCAN_DIR/nuclei_results.txt" || echo "Nuclei failed."

# OWASP ZAP for web vulnerability scanning
echo "Running OWASP ZAP for web application scanning..."
zap-cli quick-scan --start-options '-config api.disablekey=true' --spider --active-scan https://$DOMAIN || echo "OWASP ZAP failed."

echo "Scan completed. Results saved in $SCAN_DIR"

