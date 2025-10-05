import os
import importlib.util

PERMISSION_ROLES = {
    "read_only": ["read_sysinfo", "read_config"],
    "standard": ["read_sysinfo", "read_config", "write_log"],
    "advanced": ["read_sysinfo", "read_config", "write_log", "exec_safe"],
    "admin": ["read_sysinfo", "read_config", "write_log", "exec_safe", "delete_files"]
}

def get_plugin_permissions(role):
    return PERMISSION_ROLES.get(role, [])

def load_manifest(plugin_path):
    manifest_file = os.path.join(plugin_path, "plugin.manifest")
    manifest = {
        "name": os.path.basename(plugin_path),
        "role": "read_only",
        "required_version": "1.1.0"
    }
    if os.path.exists(manifest_file):
        with open(manifest_file) as f:
            for line in f:
                if "=" in line:
                    key, value = line.strip().split("=", 1)
                    manifest[key.strip()] = value.strip().strip('"')
    return manifest

def import_plugin(plugin_path):
    plugin_file = os.path.join(plugin_path, "plugin.py")
    spec = importlib.util.spec_from_file_location("plugin", plugin_file)
    plugin = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(plugin)
    return plugin

def load_plugins(plugin_dir, pluginguard=None):
    plugins = []
    for name in os.listdir(plugin_dir):
        path = os.path.join(plugin_dir, name)
        if os.path.isdir(path):
            manifest = load_manifest(path)
            plugin = import_plugin(path)

            # Attach metadata
            plugin.name = manifest["name"]
            plugin.role = manifest["role"]
            plugin.required_version = manifest["required_version"]

            # Inject pluginguard if available
            if pluginguard:
                plugin.safe_exec = lambda cmd: pluginguard.safe_exec(cmd, plugin.role)
                plugin.safe_write = lambda p, c: pluginguard.safe_write(p, c, plugin.role)
                plugin.safe_delete = lambda p: pluginguard.safe_delete(p, plugin.role)

            plugins.append(plugin)
    return plugins

def run_plugins(plugins, cfg):
    for plugin in plugins:
        if hasattr(plugin, "run"):
            plugin.run(cfg)

def list_plugins(plugins):
    for plugin in plugins:
        print(f"- {getattr(plugin, 'name', 'Unnamed')} — {getattr(plugin, 'description', 'No description')}")
