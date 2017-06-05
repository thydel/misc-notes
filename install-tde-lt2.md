## Got a new old desktop

[Fujitsu LifeBook AH531 Specifications](https://www.cnet.com/products/fujitsu-lifebook-ah531/specs/)

## Makes an installable USB key

```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.8.0-amd64-netinst.iso
cp debian-8.8.0-amd64-netinst.iso /dev/sd$usbkeyid
```

## Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Use whole disk
  - root, var, tmp, home part
  - Use LVM
- Install Gnome, Mate, sshd

## Adds my keys

```bash
ssh-copy-id -o PreferredAuthentications=password tde-lt2
```

## configure `sudo`

`ssh tde-lt2`

```bash
su
adduser thy sudo
echo 'Defaults:thy env_keep += HOME' > /tmp/thy
sudo install -m 0440 /tmp/thy /etc/sudoers.d
```

## Add and use `x2x` from main WS

```bash
ssh tde-lt2 -t sudo aptitude install x2x
ssh -XC tde-lt2 x2x -east -to :0
```

## Install missing firmware

```bash
echo -e '/main$/s/$/ contrib non-free/\nwq' | ed /etc/apt/sources.list
aptitude update
aptitude install firmware-linux-nonfree
aptitude install firmware-iwlwifi
aptitude install firmware-realtek
shutdown -r now
```

## Basic install

```bash
aptitude install htop
aptitude install emacs
aptitude install thunderbird
aptitude install thunderbird-l10n-fr
aptitude install mate-netspeed
```
## Install required tools

```bash
aptitude install rsync
aptitude install make make-doc
aptitude install screen
```

## Install requires libs

```bash
aptitude install python-yaml python-jinja2 # for ansible
```

## Install chrome

```bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo deb http://dl.google.com/linux/chrome/deb/ stable main >> /etc/apt/sources.list.d/google.list
aptitude update
aptitude install google-chrome-stable
```

## Install acroread

```bash
wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
dpkg --add-architecture i386
aptitude update
which gdebi || aptitude install gdebi
gdebi -n AdbeRdr9.5.5-1_i386linux_enu.deb
aptitude install libxml2:i386 libstdc++6:i386
```

## Intall a recent git

```bash
echo deb http://ftp.debian.org/debian jessie-backports main >> /etc/apt/sources.list.d/jessie-backports.list
aptitude -t jessie-backports install git
```

## Use staff group

```bash
sudo adduser thy staff
newgrp staff
newgrp thy
```

## Uses emacs packages

See [el-get](https://github.com/dimitri/el-get)

```lisp
(el-get-bundle elpa:markdown)
(el-get-bundle elpa:markdown-toc)
```

Or maybe just uses

```lisp
(package-install 'markdown-mode)
(package-install 'markdown-toc)

(package-install 's)
(package-install 'dash)
(package-install 'gh-md)
```

## Get private stuff

```bash
(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:usr/perso.d/bash_history.git
)
```

## Get my repositories

### Get Helpers

```bash
mkdir -p ~/usr/thydel.p
git -C ~/usr/thydel.d clone git@thydel.github.com:thydel/helpers.git
(cd ~/usr/thydel.d/helpers; ./helper.mk install)
```

### Get all repositories

```bash
cd ~/usr/thydel.d
ln -s helper/thydel.mk Makefile
make thydel
```

## Install and use some local tools

### `git-dates` require `propagate-date`

```bash
cd ~/usr/thydel.d/helpers
make -C ../propagate-date/ install
git-dates run date
```

### Install ansible

```bash
mkdir ~/usr/ext
use-ansible help
(cd ~/usr/ext; git clone --branch stable-2.3 --recursive git://github.com/ansible/ansible.git ansible-stable-2.3)
```

### Install my bashrc, my dotemacs

```bash
cd ~/usr/thydel.d/ar-my-bash-rc
helper ansible
bashrc-play.yml -i localhost, -c local -DC
cd ~/usr/thydel.d/ar-my-dotemacs
dotemacs-play.yml -i localhost, -c local -D
```

