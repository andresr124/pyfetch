# PyFetch
The neofetch alternative that is python-based. Displays information about your desktop.

## What it does

- Detects your distro and uses python-pyfiglet to display text in ASCII art.
- CPU, RAM, and hostname information.
- If your distro fails to be detected, python-pyfiglet will use the "PyFetch" fallback text.

## How to install PyFetch

### From AUR (Arch-only)
```bash
yay -S pyfetch
```

### Other ways
You will be installing git clone command.
This method will not automatically install dependencies.
Simply run this command:
```bash
git clone https://github.com/andresr124/pyfetch.git
```
Then rename main.py to pyfetch (with no file extension).
Then move pyfetch to /usr/bin/

## Dependencies
These are the Dependencies you will need to have in order to use PyFetch:

- python3
- python-pyfiglet

Install python-pyfiglet with:
```bash
pip install pyfiglet
```
or
```bash
yay -S python-pyfiglet
```

## License
MIT License - see [LICENSE](LICENSE)

## Credits
Inspired by [Neofetch](https://github.com/dylanaraps/neofetch)
