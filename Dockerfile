# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    nmap \
    amass \
    subfinder \
    assetfinder \
    nuclei \
    zaproxy \
    git \
    curl \
    python3 \
    python3-pip

# Install Python requirements for OWASP ZAP
RUN pip3 install zap-cli

# Set up working directory
WORKDIR /app

# Copy the scan script and README
COPY scan.sh /app/scan.sh
COPY README.md /app/README.md

# Make the scan script executable
RUN chmod +x /app/scan.sh

# Create a results directory
RUN mkdir /app/results

# Run the scan script by default
CMD ["/app/scan.sh"]

