#!/bin/bash

# Ask the user for Order ID
echo "Please enter Order ID:"
read OrderID

# Define the log directory and temp directory
LOG_DIR="/Logs/$USER" #Please amend for your system
TEMP_DIR="/tmp/$OrderID"

# Create a directory in /tmp with the Order ID name
mkdir -p "$TEMP_DIR"

# Search and copy relevant log files to the temporary directory
find "$LOG_DIR" -type f \( -name "*log*" \) -exec grep -l "$OrderID" {} \; -exec cp {} "$TEMP_DIR" \;

# Compress the folder into a tar.gz archive
tar -czvf "/tmp/${OrderID}.tar.gz" -C "/tmp" "$OrderID"

echo "All files containing Order ID $OrderID have been copied and compressed into /tmp/${OrderID}.tar.gz"
