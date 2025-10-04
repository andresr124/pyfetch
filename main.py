#!/usr/bin/env python3

import platform
import getpass
import socket
import psutil
import pyfiglet
import os
import subprocess

# Load battery percentage
def get_battery_percentage():
    try:
        output = subprocess.check_output(
            "upower -i $(upower -e | grep BAT) | grep percentage",
            shell=True, text=True
        )
        return output.strip().split(":")[1].strip()
    except Exception:
        return "Battery info not available"

# Load shell version
def get_shell_version():
    shell_path = os.environ.get("SHELL", "")
    shell_name = os.path.basename(shell_path)

    try:
        version_output = subprocess.check_output([shell_name, '--version'], stderr=subprocess.STDOUT, text=True)
        return version_output.split('\n')[0]  # First line only
    except Exception:
        return f"{shell_name} (version unknown)"

# Load ~/.config/pyfetch/pyfetch.conf
def load_conf(path):
    config = {}
    if not os.path.exists(path):
        return config

    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if '=' not in line:
                continue
            key, value = line.split('=', 1)
            config[key.strip()] = value.strip().lower()
    return config

# Load config
cfg = load_conf(os.path.expanduser("~/.config/pyfetch/pyfetch.conf"))

# Getting distro name
def get_distro_name():
    try:
        with open("/etc/os-release") as f:
            for line in f:
                if line.startswith("PRETTY_NAME="):
                    return line.strip().split("=")[1].strip('"')
    except FileNotFoundError:
        return None

# Read raw config line (not just parsed values)
config_path = os.path.expanduser("~/.config/pyfetch/pyfetch.conf")
banner_text = None

# Checking for banner
with open(config_path) as f:
    for line in f:
        if "banner_text" in line:
            if line.strip().startswith("#"):
                banner_text = get_distro_name()
            else:
                banner_text = line.split("=", 1)[1].strip()
            break

if banner_text is None:
    banner_text = get_distro_name()

ascii_banner = pyfiglet.figlet_format(banner_text)

# Find amount of packages
def get_package_count():
    managers = {
        "pacman": "pacman -Q",
        "dpkg": "dpkg -l | grep '^ii'",
        "rpm": "rpm -qa",
        "apk": "apk info",
        "xbps-query": "xbps-query -l",
        "pkg": "pkg info"
    }

    for cmd, query in managers.items():
        if subprocess.call(f"which {cmd}", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0:
            try:
                output = subprocess.check_output(query + " | wc -l", shell=True)
                return int(output.strip())
            except Exception:
                return None
    return None

if cfg.get('ascii_art', 'true') == 'true':
    print(ascii_banner)
if cfg.get('show_distro', 'true') == 'true':
    print(f"Distro: {get_distro_name()}")
print(f"Hostname: {socket.gethostname()}")
print(f"User: {getpass.getuser()}")
if cfg.get('show_kernel', 'true') == 'true':
    print(f"Kernel: {platform.system()} {platform.release()}")
if cfg.get('show_packages', 'true') == 'true':
    pkg_count = get_package_count()
    if pkg_count is not None:
        print(f"Packages: {pkg_count}")
    else:
        print("Packages: Unknown")
if cfg.get('show_pyfversion', 'true') == 'true':
    print(f"PyFetch Version: 1.0.2")
if cfg.get('show_shell_version', 'true') == 'true':
    print("Shell:", get_shell_version())
if cfg.get('show_battery', 'true') == 'true':
    print("Battery: ", get_battery_percentage())
print(f"CPU: {os.uname().machine}")
print(f"RAM: {round(psutil.virtual_memory().total / (1024**3), 2)} GB")
