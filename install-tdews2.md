# Got a new old desktop

See [HP 260 G2 Desktop Mini PC - Specifications][]

[HP 260 G2 Desktop Mini PC - Specifications]:
	https://support.hp.com/th-en/document/c05121551 "support.hp.com"

# Makes an installable USB key

```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.4.0-amd64-netinst.iso
cp debian-9.4.0-amd64-netinst.iso /dev/sd$usbkeyid
```

Note:

> Really, used a previously made debian-9.3.0-amd64-netinst.iso

# Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Use whole disk
  - root, var, tmp, home part
  - Use encrypted LVM
- Install Gnome, Mate, sshd

# First local steps

## sudo

Login using mate and use `su` add us to `sudo` group
```
su
adduser thy sudo
exit
mate-session-save --logout
```

Login again to use `sudo`

Allows passwordless sudo during install
```
echo 'thy ALL=(ALL:ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/thy
```

Use my dotfiles when in sudo
```
echo 'Defaults:thy env_keep += HOME' | sudo tee -a /etc/sudoers.d/thy
```

Install `aptitude` and `deborphan`
```
sudo apt-get install aptitude
echo 'aptitude update; aptitude full-upgrade' | sudo dash
echo 'aptitude install deborphan; deborphan' | sudo dash
```

# first remote steps

## install key
```
ssh-copy-id -i ~/.ssh/t.delamare@laposte.net -o PreferredAuthentications=password tdews2
ssh tdews2 sudo aptitude install emacs25-lucid
```

## find MAC (7c:d3:0a:2f:c2:21)

Parse `lshw` output with [find-eth-name](find-eth-name.jq) `jq`
script


```
ssh tdews2 sudo aptitude install lshw jq ethtool
ssh tdews2 sudo lshw -json | find-eth-name.jq | ssh tdews2 sudo xargs ethtool -P
```
# Usual DHCP and DNS setup

# Add and use `x2x` from main WS

```
ssh tdews2 sudo aptitude install x2x
ssh -XC tdews2 x2x -east -to :0
```

# install some packages

## Setup apt sources

```
ssh tdews2 sudo aptitude install ed
echo -e 'g/^[^#].*main/s/main/main contrib non-free/\nwq' | ssh tdews2 sudo ed /etc/apt/sources.list
ssh tdews2 sudo aptitude update
ssh tdews2 sudo aptitude install firmware-linux
ssh tdews2 sudo aptitude install apt-file
ssh tdews2 sudo apt-file update
```

## Fix missing firmware

```
ssh tdews2 sudo grep firmware /var/log/kern.log | grep failed
list-missing-firmware-file | ssh tdews2 xargs apt-file search {}
list-missing-firmware-pkg  | xargs aptitude install {}
```

Note:

> `list-missing-firmware-file` and `list-missing-firmware-pkg` are fictive commands

```
ssh tdews2 sudo aptitude install firmware-misc-nonfree firmware-realtek
```

## Basic install

```
ssh tdews2 sudo aptitude install htop hdparm net-tools
ssh tdews2 sudo aptitude install thunderbird thunderbird-l10n-fr thunderbird-enigmail
```

## Install required tools

```
ssh tdews2 sudo aptitude install netcat-openbsd git rsync make make-doc screen
```

## Install requires libs

### ansible

```
ssh tdews2 sudo aptitude install python-yaml python-jinja2 python-paramiko python-apt
ssh tdews2 sudo aptitude install python-pip
ssh tdews2 sudo -H pip install pycrypto
```

## Install chrome

On `tdews2`
```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo deb http://dl.google.com/linux/chrome/deb/ stable main | sudo tee -a /etc/apt/sources.list.d/google.list
sudo aptitude update
sudo aptitude install google-chrome-stable
```

## Install acroread

On `tdews2`
```
wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
sudo dpkg --add-architecture i386
sudo aptitude update
which gdebi || sudo aptitude install gdebi
sudo aptitude install libxml2:i386 libstdc++6:i386
sudo gdebi -n AdbeRdr9.5.5-1_i386linux_enu.deb
```

# Use staff group

On `tdews2`
```
sudo adduser thy staff
newgrp staff
newgrp thy
```

# Get private stuff

```
(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:usr/perso.d/private.git;
	ln -s private/perso.mk Makefile;
	make perso;
)
```

