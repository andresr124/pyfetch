#!/bin/bash

echo "Preparing to install pyfetch..."
sleep 1

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "python3 is not installed. Please install it now."
    exit 1
fi

# Check if Python Pip is installed
if grep -qi arch /etc/os-release; then
    echo "Arch detected, skipping pip check."
else
    if ! command -v pip &> /dev/null; then
      echo "Python Pip is not installed. Please install it now."
      exit 1
    fi
fi

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run install.sh as root. This is unsafe!"
  exit 1
fi

# Start installation process
read -p "Do you want to install pyfetch? (y/n): " choice

case "$choice" in
  y|Y )
    echo "Installing dependencies..."
    if grep -qi arch /etc/os-release; then
      sudo pacman -S --noconfirm python-pyfiglet
    else
      pip install pyfiglet
    fi
    sleep 1
    echo "Installing pyfetch..."
    if [ -f /usr/bin/pyfetch ]; then
      echo "pyfetch detected, reinstalling..."
      sudo rm /usr/bin/pyfetch
      rm -rf ~/.config/pyfetch
      mkdir ~/.config/pyfetch
      sudo cp ./.files/pyfetch /usr/bin/pyfetch
      cp ./.files/config/pyfetch.conf ~/.config/pyfetch/pyfetch.conf
      sudo chmod +x /usr/bin/pyfetch
    else
      if [ -f ~/.config/pyfetch ]; then
        rm -rf ~/.config/pyfetch
        mkdir ~/.config/pyfetch
        cp ./.files/config/pyfetch.conf ~/.config/pyfetch/pyfetch.conf
      else
        mkdir ~/.config/pyfetch
        cp ./.files/config/pyfetch.conf ~/.config/pyfetch/pyfetch.conf
      fi
      sudo cp ./.files/pyfetch /usr/bin/pyfetch
      sudo chmod +x /usr/bin/pyfetch
    fi

    echo "pyfetch is now installed."

    # Optional Files
    read -p "Do you want to download optional documents? (y/n): " optionalchoice

    case "$optionalchoice" in
      y|Y )
        mkdir ~/Documents/pyfetch
        cp ./.files/optional/LICENSE ~/Documents/pyfetch/LICENSE
        cp ./.files/optional/LICENSE ~/Documents/pyfetch/README.md
        echo "Completed. Go to ~/Documents/pyfetch to read them."
      ;;
      n|N )
        echo "Exiting..."
        sleep 1
      ;;
      * )
        echo "Wrong input. Please type in y/n."
      ;;
    esac
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
