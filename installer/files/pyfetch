#!/usr/bin/env python3

import platform
import getpass
import socket
import psutil
import pyfiglet
import os

def get_distro_name():
    try:
        with open("/etc/os-release") as f:
            for line in f:
                if line.startswith("PRETTY_NAME="):
                    return line.strip().split("=")[1].strip('"')
    except FileNotFoundError:
        return None

distro = get_distro_name()
logo_text = distro if distro else "PyFetch"

print(pyfiglet.figlet_format(logo_text))
print(f"Distro: {get_distro_name()}")
print(f"Hostname: {socket.gethostname()}")
print(f"User: {getpass.getuser()}")
print(f"Kernel: {platform.system()} {platform.release()}")
print(f"CPU: {os.uname().machine}")
print(f"RAM: {round(psutil.virtual_memory().total / (1024**3), 2)} GB")
