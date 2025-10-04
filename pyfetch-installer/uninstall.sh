#!/bin/bash

echo "Preparing to uninstall pyfetch..."
sleep 1

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run uninstall.sh as root. This is unsafe!"
  exit 1
fi

# Start uninstallation process
read -p "Are you sure you want to uninstall pyfetch? (y/n): " choice

case "$choice" in
  y|Y )
    echo "NOTE: This will not uninstall the dependencies."
    sleep 1
    echo "Uninstalling pyfetch..."
    if [ -f /usr/bin/pyfetch-beta ]; then
        sudo rm /usr/bin/pyfetch-beta
        rm -rf ~/.config/pyfetch
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
