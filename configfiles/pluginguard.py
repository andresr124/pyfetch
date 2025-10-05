import os
import sys
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
cfg = load_conf(os.path.expanduser("~/.config/pyfetch/pyfetch.conf"))

# List of protected files and folders
pluginguard_path = os.path.expanduser("~/.config/pyfetch/pluginguard.py")
pyfetchconf_path = os.path.expanduser("~/.config/pyfetch/pyfetch.conf")
pluginloader_path = os.path.expanduser("~/.config/pyfetch/pluginloader.py")
PROTECTED_PATHS = [
    pyfetchconf_path,
    pluginguard_path,
    pluginloader_path,
    "/usr/bin/pyfetch",  # Adjust if your binary lives elsewhere
]

# Make pluginguard recognize Permission Roles
PERMISSION_ROLES = {
    "read_only": ["read_sysinfo", "read_config"],
    "standard": ["read_sysinfo", "read_config", "write_log"],
    "advanced": ["read_sysinfo", "read_config", "write_log", "exec_safe"],
    "admin": ["read_sysinfo", "read_config", "write_log", "exec_safe", "delete_files"]
}

# Sandbox Enforcement
if cfg.get('sandbox_mode', 'true') == 'true':
    def is_action_allowed(role, action):
        allowed = ROLE_PERMISSIONS.get(role, [])
        return action in allowed

    def safe_delete(path, role):
        if not is_action_allowed(role, "delete_files"):
            raise PermissionError(f"Role '{role}' not allowed to delete files.")
        os.remove(path)

    def safe_write(path, content, role):
        if not is_action_allowed(role, "write_log"):
            raise PermissionError(f"Role '{role}' not allowed to write logs.")
        with open(path, "w") as f:
            f.write(content)

    def safe_exec(command, role):
        if not is_action_allowed(role, "exec_safe"):
            raise PermissionError(f"Role '{role}' not allowed to execute commands.")
        os.system(command)

# Audit log (optional)
AUDIT_LOG = os.path.expanduser("~/.config/pyfetch/plugin_audit.log")

def log_action(action, path):
    with open(AUDIT_LOG, "a") as log:
        log.write(f"[PLUGIN ACTION] {action}: {path}\n")

def safe_delete(path):
    if path in PROTECTED_PATHS:
        raise PermissionError(f"Plugin tried to delete protected file: {path}")
    log_action("DELETE", path)
    os.remove(path)

def safe_write(path, content):
    if path in PROTECTED_PATHS:
        raise PermissionError(f"Plugin tried to overwrite protected file: {path}")
    log_action("WRITE", path)
    with open(path, "w") as f:
        f.write(content)

def safe_exec(command):
    # Optional: restrict dangerous commands
    if "rm" in command or "sudo" in command:
        raise PermissionError(f"Plugin tried to execute risky command: {command}")
    log_action("EXEC", command)
    os.system(command)

def activate():
    print("PluginGuard activated — critical files protected.")
