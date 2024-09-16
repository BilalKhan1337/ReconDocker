# Use an official Ubuntu base image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    nmap \
    amass \
    subfinder \
    assetfinder \
    nuclei \
    zaproxy \
    git \
    curl

# Set up working directory
WORKDIR /app

# Copy the scan script
COPY scan.sh /app/scan.sh

# Make the scan script executable
RUN chmod +x /app/scan.sh

# Create a results directory
RUN mkdir /app/results

# Run the scan script by default
CMD ["/app/scan.sh"]

