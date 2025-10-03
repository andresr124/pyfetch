#!/bin/bash

echo "Preparing to install pyfetch..."
echo "NOTE: If you are installing on Arch, please install via AUR instead."
sleep 1

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "python3 is not installed. Please install it now."
    exit 1
fi

# Check if Python Pip is installed
if ! command -v pip &> /dev/null; then
    echo "Python Pip is not installed. Please install it now."
    exit 1
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This installer is not running as root. Please run 'sudo ./install.sh' next time."
  sleep 1
  exit 1
fi

# Start installation process
read -p "Do you want to install pyfetch? (y/n): " choice

case "$choice" in
  y|Y )
    echo "Installing dependencies..."
    pip install --user pyfiglet
    sleep 1
    echo "Installing pyfetch..."
    cp ./files/pyfetch /usr/bin/pyfetch
    chmod +x /usr/bin/pyfetch

    echo "pyfetch is now installed."
    ;;
  n|N )
    echo "Installation aborted."
    exit 0
    ;;
  * )
    echo "Wrong input. Please type in y/n."
    exit 1
    ;;
esac
