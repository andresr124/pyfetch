#!/bin/bash

echo "Preparing to uninstall pyfetch..."
sleep 1

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This installer is not running as root. Please run 'sudo ./uninstall.sh' next time."
  sleep 1
  exit 1
fi

# Start uninstallation process
read -p "Are you sure you want to uninstall pyfetch? (y/n): " choice

case "$choice" in
  y|Y )
    echo "NOTE: This will not uninstall the dependencies."
    sleep 1
    echo "Uninstalling pyfetch..."
    if [ -f /usr/bin/pyfetch ]; then
        rm /usr/bin/pyfetch
        echo "pyfetch is now uninstalled."
    else
        echo "pyfetch is not detected on /usr/bin/. Stop."
    fi
    ;;
  n|N )
    echo "Uninstallation aborted."
    exit 0
    ;;
  * )
    echo "Wrong input. Please type in y/n."
    exit 1
    ;;
esac
