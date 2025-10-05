# PyFetch Plugins
PyFetch Plugins are plugins that expands PyFetch to the furtherest it can go. There are 2 files in 1 plugin folder, plugin.py and plugin.manifest. These 2 files are the core of the plugin. PyFetch v1.1.0 and above uses the 2 files while PyFetch v1.1.0 RC2 and RC3 uses a single .py file.
## Permission Roles
Permission Roles are roles that gives plugins certain permissions. There are 4 permission roles; read_only, standard, advanced, and admin. read_only is the strictest permission role ever while admin is the most unrestricted role ever. Before using a plugin, it is recommended to read the plugin.manifest file to see the permission role the plugin has before using it.
## Plugin Guard
Plugin Guard (/home/username/.config/pyfetch/pluginguard.py) is a security script 100% written in Python to make sure PyFetch Plugins doesn't run dangerous commands (Like for example, sudo rm -rf /) and if disabled, can keep PyFetch and your entire system vulnerable to viruses disguised as useful PyFetch Plugins. You can disable Plugin Guard through pyfetch.conf (/home/username/.config/pyfetch/pyfetch.conf) but it is highly discouraged to do so.
### Sandboxing for PyFetch Plugins
This feature is baked into PluginGuard but can be disabled seperately through pyfetch.conf (/home/username/.config/pyfetch/pyfetch.conf). This feature is used to make sure Plugins doesn't have access to network nor file access unless allowed by Permission roles.
