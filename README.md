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
Unfortunately, there is no other way to install PyFetch (yet).
The only way to do it outside of Arch is by copying the AUR version of it then completely move the pyfetch file to /usr/bin/.
If you don't want to do that, that is your only choice sadly.

## Dependencies
These are the Dependencies you will need to have in order to use PyFetch:

- python3
- python-pyfiglet

Install python-pyfiglet with:
```bash
pip install pyfiglet
```

## License
MIT License - see [LICENSE](LICENSE)

## Credits
Inspired by [Neofetch](https://github.com/dylanaraps/neofetch)
