# <img width="288" height="106" alt="image" src="https://github.com/user-attachments/assets/ae0dde08-5c3b-4bf6-a70f-05067366faaf" />
The neofetch alternative that is python-based. Displays information about your desktop. (Not to be confused with Tyrowin's project which is also called pyfetch.)

<img width="410" height="304" alt="image" src="https://github.com/user-attachments/assets/2661a3e1-b78e-4409-8931-02ad530ab341" />

## What it does

- Detects your distro and uses python-pyfiglet to display text in ASCII art.
- CPU, RAM, and hostname information.
- If your distro fails to be detected, python-pyfiglet will use the "PyFetch" fallback text.

## How to install PyFetch
There is a tarball installer on github releases. Download it then extract it then run this command in the install folder:
```bash
sudo ./install.sh
```

## Dependencies
These are the Dependencies you will need to have in order to use PyFetch:

- python3
- pyfiglet
- packaging

Install python-pyfiglet & python-packaging with:
```bash
pip install pyfiglet
pip install packaging
```
or
```bash
sudo pacman -S python-pyfiglet python-packaging
```

## License
MIT License - see [LICENSE](LICENSE)

## Credits
Inspired by [Neofetch](https://github.com/dylanaraps/neofetch)
