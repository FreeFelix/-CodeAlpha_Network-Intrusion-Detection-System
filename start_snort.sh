#!/bin/bash

INTERFACE="eth0"  # Replace with your network interface
CONFIG="/etc/snort/snort.conf"
LOGDIR="/var/log/snort"

sudo snort -A console -q -c $CONFIG -i $INTERFACE -l $LOGDIR
