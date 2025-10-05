import os
import platform

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

def run(cfg):
    print(f"Hey, it's me the template plugin!")
