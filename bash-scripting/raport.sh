#!/bin/bash

# File to store the report
report_file="system_report.txt"

# Function to get external IP address
get_external_ip() {
  curl -s ifconfig.me
}

# Function to get Linux distribution name and version
get_linux_distribution() {
  if [[ -f /etc/os-release ]]; then
    grep -oP 'NAME="\K[^"]+' /etc/os-release
    grep -oP 'VERSION="\K[^"]+' /etc/os-release
  elif [[ -f /etc/lsb-release ]]; then
    grep -oP 'DISTRIB_ID=\K[^"]+' /etc/lsb-release
    grep -oP 'DISTRIB_RELEASE=\K[^"]+' /etc/lsb-release
  elif [[ -f /etc/redhat-release ]]; then
    cat /etc/redhat-release
  else
    echo "Unknown distribution"
  fi
}

# Function to get CPU cores and frequency
get_cpu_info() {
  cpu_cores=$(grep -c '^processor' /proc/cpuinfo)
  cpu_frequency=$(grep -m1 'cpu MHz' /proc/cpuinfo | awk '{print $4}')
  echo "CPU Cores: $cpu_cores"
  echo "CPU Frequency: $cpu_frequency MHz"
}

# Generate the system report
echo "Report generated on: $(date)" > "$report_file"
echo "Current User: $(whoami)" >> "$report_file"
echo "Internal IP Address: $(hostname -I)" >> "$report_file"
echo "Hostname: $(hostname)" >> "$report_file"
echo "External IP Address: $(get_external_ip)" >> "$report_file"
echo "Linux Distribution:" >> "$report_file"
get_linux_distribution >> "$report_file"
echo "System Uptime:" >> "$report_file"
uptime >> "$report_file"
echo "Disk Space:" >> "$report_file"
df -h / >> "$report_file"
echo "RAM Information:" >> "$report_file"
free -h >> "$report_file"
echo "CPU Information:" >> "$report_file"
get_cpu_info >> "$report_file"

echo "System report generated and saved in: $report_file"

