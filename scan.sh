#!/bin/bash

# Input domain as the first argument
DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "Please provide a domain to scan."
  exit 1
fi

# Create results directory for this scan
SCAN_DIR="/app/results/$DOMAIN"
mkdir -p "$SCAN_DIR"

echo "Starting scan for domain: $DOMAIN"

# Subdomain enumeration using Amass
echo "Running Amass for subdomain enumeration..."
amass enum -d $DOMAIN -o "$SCAN_DIR/amass_subdomains.txt"

# Subdomain enumeration using Subfinder
echo "Running Subfinder for subdomain enumeration..."
subfinder -d $DOMAIN -o "$SCAN_DIR/subfinder_subdomains.txt"

# Merge results
cat "$SCAN_DIR/amass_subdomains.txt" "$SCAN_DIR/subfinder_subdomains.txt" | sort -u > "$SCAN_DIR/all_subdomains.txt"

# Port scanning using Nmap
echo "Running Nmap for port scanning..."
nmap -Pn -p- -iL "$SCAN_DIR/all_subdomains.txt" -oN "$SCAN_DIR/nmap_results.txt"

# Running Nuclei for vulnerability scanning
echo "Running Nuclei for vulnerability scanning..."
nuclei -l "$SCAN_DIR/all_subdomains.txt" -o "$SCAN_DIR/nuclei_results.txt"

# Running OWASP ZAP for web vulnerability scanning
echo "Running OWASP ZAP for web application scanning..."
zap-baseline.py -t https://$DOMAIN -r "$SCAN_DIR/zap_report.html"

echo "Scan completed. Results saved in $SCAN_DIR"

