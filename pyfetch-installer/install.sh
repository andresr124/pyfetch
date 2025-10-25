#!/bin/sh

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
elif grep -qi void /etc/os-release; then
    echo "Void Linux detected, skipping pip check."
elif grep -qi fedora /etc/os-release; then
    echo "Fedora detected, skipping pip check."
elif grep -qi ubuntu /etc/os-release; then
    echo "Ubuntu detected, skipping pip check."
elif grep -qi zorin /etc/os-release; then
    echo "Zorin OS detected, skipping pip check."
elif grep -qi debian /etc/os-release; then
    echo "Saving Python Pip check for later."
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
      sudo pacman -S --noconfirm python-pyfiglet python-packaging python-psutil
    elif grep -qi void /etc/os-release; then
      sudo xbps-install -Sy python3-setuptools python3-pyfiglet python3-packaging python3-psutil
    elif grep -qi fedora /etc/os-release; then
      sudo dnf install -y python3-setuptools python3-pyfiglet python3-packaging python3-psutil
    elif grep -qi ubuntu /etc/os-release; then
      sudo apt-get install -y python3-setuptools python3-pyfiglet python3-packaging python3-psutil
    elif grep -qi zorin /etc/os-release; then
      sudo apt-get install -y python3-setuptools python3-pyfiglet python3-packaging python3-psutil
    elif grep -qi debian /etc/os-release; then
      sudo apt-get install -y python3-setuptools python3-pyfiglet python3-psutil
      echo "WARNING: Debian does not have the package python3-packaging in it's official repo. Checking for python pip..."
      sleep 1
      if ! command -v pip &> /dev/null; then
        echo "Python Pip is not installed. Good luck on getting python3-packaging!"
      else
        echo "Python Pip detected, installing packaging..."
        pip install packaging
      fi
    else
      pip install pyfiglet
      pip install packaging
      pip install python-psutil
    fi
    sleep 1
    echo "Installing pyfetch..."
    if [ -f /usr/bin/pyfetch ]; then
      echo "pyfetch detected, reinstalling..."
      sudo rm /usr/bin/pyfetch
      rm -rf ~/.config/pyfetch
      mkdir ~/.config/pyfetch
      mkdir ~/.config/pyfetch/plugins
      sudo cp ./.files/pyfetch /usr/bin/pyfetch
      cp ./.files/config/pyfetch.conf ~/.config/pyfetch/pyfetch.conf
      cp ./.files/config/pluginloader.py ~/.config/pyfetch/pluginloader.py
      cp ./.files/config/pluginguard.py ~/.config/pyfetch/pluginguard.py
      sudo chmod +x /usr/bin/pyfetch
    else
      if [ -f ~/.config/pyfetch ]; then
        rm -rf ~/.config/pyfetch
        mkdir ~/.config/pyfetch
        mkdir ~/.config/pyfetch/plugins
        cp ./.files/config/pyfetch.conf ~/.config/pyfetch/pyfetch.conf
        cp ./.files/config/pluginloader.py ~/.config/pyfetch/pluginloader.py
        cp ./.files/config/pluginguard.py ~/.config/pyfetch/pluginguard.py
      else
        mkdir ~/.config/pyfetch
        mkdir ~/.config/pyfetch/plugins
        cp ./.files/config/pyfetch.conf ~/.config/pyfetch/pyfetch.conf
        cp ./.files/config/pluginloader.py ~/.config/pyfetch/pluginloader.py
        cp ./.files/config/pluginguard.py ~/.config/pyfetch/pluginguard.py
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
