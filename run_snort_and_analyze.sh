#!/bin/bash

INTERFACE="eth0"  # Replace with your network interface
CONFIG="/etc/snort/snort.conf"
LOGDIR="/var/log/snort"
ALERT_FILE="$LOGDIR/alert"
ANALYZER_SCRIPT="snort_log_analyzer.py"

# Start Snort
sudo snort -A console -q -c $CONFIG -i $INTERFACE -l $LOGDIR

# Check if Snort has run successfully
if [ $? -eq 0 ]; then
    echo "Snort started successfully. Analyzing logs..."
    # Run the Python analyzer
    python3 $ANALYZER_SCRIPT
else
    echo "Failed to start Snort."
fi
