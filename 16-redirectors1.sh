#!/bin/bash

# Set up logging
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

# Create logs folder if it doesn't exist
mkdir -p "$LOGS_FOLDER"

# Check root privileges
CHECK_ROOT() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script with root privileges" | tee -a "$LOG_FILE"
    exit 1
  fi
}

# Validate command exit status
VALIDATE() {
  if [ "$1" -ne 0 ]; then
    echo "$2 failed" | tee -a "$LOG_FILE"
    exit 1
  else
    echo "$2 succeeded" | tee -a "$LOG_FILE"
  fi
}

# Install packages
INSTALL_PACKAGES() {
  for package in "$@"; do
    if ! rpm -q "$package" &> /dev/null; then
      echo "Installing $package..." | tee -a "$LOG_FILE"
      dnf install "$package" -y | tee -a "$LOG_FILE"
      VALIDATE $? "Installing $package"
    else
      echo "$package is already installed" | tee -a "$LOG_FILE"
    fi
  done
}

