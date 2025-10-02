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
Then test the file:
```bash
python3 main.py
```
If it runs fine, it's good! If not, follow the steps below this text:

#### Commands to run
If you use any debian-based distro:
```bash
sudo apt install python3 python3-pip
```
Or if you use fedora:
```bash
sudo dnf install python3 python3-pip
```
Then install the dependency:
```bash
pip install pyfiglet
```
Then test again:
```bash
python3 main.py
```

#### If it works
Then rename main.py to pyfetch (with no file extension).
Then move pyfetch to /usr/bin/

#### If it doesn't work
Then I don't know what to say.

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
