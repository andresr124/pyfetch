# <img width="288" height="106" alt="image" src="https://github.com/user-attachments/assets/ae0dde08-5c3b-4bf6-a70f-05067366faaf" />
The neofetch alternative that is python-based. Displays information about your desktop. (Not to be confused with Tyrowin's project which is also called pyfetch.)

<img width="410" height="304" alt="image" src="https://github.com/user-attachments/assets/2661a3e1-b78e-4409-8931-02ad530ab341" />

## What it does

- Detects your distro and uses python-pyfiglet to display text in ASCII art.
- CPU, RAM, and hostname information.
- Custom plugins to expand it further.
- If your distro fails to be detected, python-pyfiglet will use the "PyFetch" fallback text.

## How to install PyFetch
There is a tarball installer on github releases. Download it then extract it then run this command in the install folder:
```bash
./install.sh
```

## Dependencies
These are the Dependencies you will need to have in order to use PyFetch:

- python3
- pyfiglet
- packaging
- psutil

Install the dependencies with:
```bash
pip install pyfiglet
pip install packaging
pip install psutil
```
or
```bash
sudo pacman -S python-pyfiglet python-packaging python-psutil
```

## CLI Flags
There are flags for PyFetch that you can use!
- --h/--help (Show help message)
- --minimal (Show minimal output)
- --banner (Show banner ONLY)
- --version (Version of PyFetch)
- --shell (View your bash version)
- --skipconfig (Skip pyfetch.conf)
- --noplugins (Exclude Plugins)
- --list-plugins (List all avaliable plugins)

## License
MIT License - see [LICENSE](LICENSE)

## Credits
Inspired by [Neofetch](https://github.com/dylanaraps/neofetch)
