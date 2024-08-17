import os
import re

LOG_DIR = "/var/log/snort"
ALERT_FILE = os.path.join(LOG_DIR, "alert")

def parse_alerts(alert_file):
    with open(alert_file, 'r') as file:
        logs = file.readlines()
    alerts = []
    for log in logs:
        if "sid:" in log:
            alerts.append(log.strip())
    return alerts

def display_alerts(alerts):
    for alert in alerts:
        print(alert)

if __name__ == "__main__":
    if os.path.exists(ALERT_FILE):
        alerts = parse_alerts(ALERT_FILE)
        if alerts:
            print("Detected Alerts:")
            display_alerts(alerts)
        else:
            print("No alerts detected.")
    else:
        print(f"Alert file {ALERT_FILE} not found.")
