#!/bin/bash

# Step 1: Update the package list
echo "Step 1: Updating package list..."
sudo apt-get update -y
if [ $? -eq 0 ]; then
    echo "Package list updated successfully."
else
    echo "Failed to update package list."
    exit 1
fi

# Step 2: Install Snort
echo "Step 2: Installing Snort..."
sudo apt-get install snort -y
if [ $? -eq 0 ]; then
    echo "Snort installed successfully."
else
    echo "Failed to install Snort."
    exit 1
fi

# Step 3: Verify Snort Installation
echo "Step 3: Verifying Snort installation..."
snort -V
if [ $? -eq 0 ]; then
    echo "Snort installation verified successfully."
else
    echo "Snort installation verification failed."
    exit 1
fi

# Step 4: Configure Snort
# Set variables
SNORT_CONF="/etc/snort/snort.conf"
RULE_PATH="/etc/snort/rules"
HOME_NET="192.168.1.0/24"
EXTERNAL_NET="any"

# Step 5: Edit the configuration file to set network variables and include custom rules
echo "Step 4: Configuring Snort..."

# Backup the original configuration file
sudo cp $SNORT_CONF "${SNORT_CONF}.bak"
if [ $? -eq 0 ]; then
    echo "Snort configuration file backed up successfully."
else
    echo "Failed to back up Snort configuration file."
    exit 1
fi

# Replace HOME_NET and EXTERNAL_NET variables in the configuration file
sudo sed -i "s#var HOME_NET any#var HOME_NET $HOME_NET#g" $SNORT_CONF
sudo sed -i "s#var EXTERNAL_NET any#var EXTERNAL_NET $EXTERNAL_NET#g" $SNORT_CONF

if [ $? -eq 0 ]; then
    echo "Network variables set successfully in Snort configuration."
else
    echo "Failed to set network variables in Snort configuration."
    exit 1
fi

# Add custom rules to the configuration file
echo "include $RULE_PATH/local.rules" | sudo tee -a $SNORT_CONF
if [ $? -eq 0 ]; then
    echo "Custom rules included successfully in Snort configuration."
else
    echo "Failed to include custom rules in Snort configuration."
    exit 1
fi

echo "Snort configuration complete."

# Step 6: Notify the user
echo "Snort has been installed and configured successfully."
echo "Please review the configuration at $SNORT_CONF if necessary."
