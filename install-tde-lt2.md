<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Got a new old desktop](#got-a-new-old-desktop)
- [Makes an installable USB key](#makes-an-installable-usb-key)
- [Default install as usual](#default-install-as-usual)
- [Adds my keys](#adds-my-keys)
- [configure `sudo`](#configure-sudo)
- [Add and use `x2x` from main WS](#add-and-use-x2x-from-main-ws)
- [Install missing firmware](#install-missing-firmware)
- [install some packages](#install-some-packages)
    - [Basic install](#basic-install)
    - [Install required tools](#install-required-tools)
    - [Install requires libs](#install-requires-libs)
    - [Install chrome](#install-chrome)
    - [Install acroread](#install-acroread)
    - [Intall a recent git](#intall-a-recent-git)
- [Use staff group](#use-staff-group)
- [Uses emacs packages](#uses-emacs-packages)
    - [first try, `el-get`](#first-try-el-get)
    - [second try `package-install`](#second-try-package-install)
    - [uses `package-activated-list` from an already configured workstation](#uses-package-activated-list-from-an-already-configured-workstation)
- [Get private stuff](#get-private-stuff)
- [Get my repositories](#get-my-repositories)
    - [Get Helpers](#get-helpers)
    - [Get all repositories](#get-all-repositories)
- [Install and use some local tools](#install-and-use-some-local-tools)
    - [`git-dates` require `propagate-date`](#git-dates-require-propagate-date)
    - [Install ansible simple way](#install-ansible-simple-way)
    - [Install a locally built ansible](#install-a-locally-built-ansible)
    - [Install my bashrc, my dotemacs](#install-my-bashrc-my-dotemacs)
- [pass and GPG](#pass-and-gpg)
    - [Install pass and get pass data](#install-pass-and-get-pass-data)
    - [Get my GPG key](#get-my-gpg-key)
    - [Conf gpg-agent](#conf-gpg-agent)
- [take care of ssh-agent](#take-care-of-ssh-agent)
    - [remote servers](#remote-servers)
    - [remote desktops](#remote-desktops)
- [Install Samsung SL-M3320ND](#install-samsung-sl-m3320nd)

<!-- markdown-toc end -->

# Got a new old desktop

[Fujitsu LifeBook AH531 Specifications](https://www.cnet.com/products/fujitsu-lifebook-ah531/specs/)

# Makes an installable USB key

```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.8.0-amd64-netinst.iso
cp debian-8.8.0-amd64-netinst.iso /dev/sd$usbkeyid
```

# Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Use whole disk
  - root, var, tmp, home part
  - Use LVM
- Install Gnome, Mate, sshd

# Adds my keys

```bash
ssh-copy-id -o PreferredAuthentications=password tde-lt2
```

# configure `sudo`

`ssh tde-lt2`

```bash
su
adduser thy sudo
echo 'Defaults:thy env_keep += HOME' > /tmp/thy
sudo install -m 0440 /tmp/thy /etc/sudoers.d
```

# Add and use `x2x` from main WS

```bash
ssh tde-lt2 -t sudo aptitude install x2x
ssh -XC tde-lt2 x2x -east -to :0
```

# Install missing firmware

```bash
echo -e '/main$/s/$/ contrib non-free/\nwq' | ed /etc/apt/sources.list
aptitude update
aptitude install firmware-linux-nonfree
aptitude install firmware-iwlwifi
aptitude install firmware-realtek
shutdown -r now
```

# install some packages

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
aptitude install python-yaml python-jinja2 python-paramiko python-crypto # for ansible
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

# Use staff group

```bash
sudo adduser thy staff
newgrp staff
newgrp thy
```

# Uses emacs packages

## first try, `el-get`

See [el-get](https://github.com/dimitri/el-get)

```lisp
(el-get-bundle elpa:markdown)
(el-get-bundle elpa:markdown-toc)
```

## we need melpa

```lisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-list-packages)
```

## second try `package-install`
Or maybe just uses

```lisp
(package-install 'markdown-mode)
(package-install 'markdown-toc)


(package-install 's)
(package-install 'dash)
(package-install 'gh-md)
```

## uses `package-activated-list` from an already configured workstation

```bash
ssh from emacsclient -s some --eval package-activated-list | tr -d '()' | tr ' ' '\n' | sort -u \
| xargs -i echo $'emacsclient -s some --eval "(package-install \'{})"'
```

# Get private stuff

```bash
(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:usr/perso.d/private.git
)
```

# Get my repositories

## Get Helpers

```bash
mkdir -p ~/usr/thydel.d
git -C ~/usr/thydel.d clone git@thydel.github.com:thydel/helpers.git
(cd ~/usr/thydel.d/helpers; ./helper.mk install)
```

## Get all repositories

```bash
cd ~/usr/thydel.d
ln -s helpers/thydel.mk Makefile
make thydel
```

# Install and use some local tools

## `git-dates` require `propagate-date`

```bash
cd ~/usr/thydel.d/helpers
make -C ../propagate-date/ install
git-dates run date
```

## Install ansible simple way

```bash
mkdir ~/usr/ext
use-ansible help
(cd ~/usr/ext; git clone --branch stable-2.3 --recursive git://github.com/ansible/ansible.git ansible-stable-2.3)
```

## Install a locally built ansible

```bash
(
cd ~/usr/thydel.d/helpers
build-ansible.mk -k deps
build-ansible.mk -k main
```

## Install my bashrc, my dotemacs

```bash
cd ~/usr/thydel.d/ar-my-bash-rc
helper ansible
bashrc-play.yml -i localhost, -c local -DC
cd ~/usr/thydel.d/ar-my-dotemacs
dotemacs-play.yml -i localhost, -c local -D
```

# pass and GPG

## Install pass and get pass data

```bash
sudo aptitude install pass
# git -C ~/usr/perso.d clone pass-store
ln -s ~/usr/perso.d/pass-store ~/.password-store 
pass git pull
```

## Conf gpg-agent

```bash
sudo aptitude install pinentry-curses pinentry-tty
echo pinentry-program /usr/bin/pinentry-tty >> ~/.gnupg/gpg-agent.conf
echo default-cache-ttl $((3600 * 24)) >> ~/.gnupg/gpg-agent.conf
echo max-cache-ttl $((3600 * 24 * 7)) >> ~/.gnupg/gpg-agent.conf
```

## Get my GPG key

```bash
ssh some gpg2 --export --armor thy | gpg2 --import
ssh -t some gpg2 --export-secret-keys --armor thy | gpg2 --import
ssh some gpg2 --export-ownertrust | gpg2 --import-ownertrust
```

## Get my GPG key, stretch

https://www.debuntu.org/how-to-importexport-gpg-key-pair/

```bash
ssh some gpg2 --export --armor thy | gpg2 --import
ssh -t some gpg2 --export-secret-keys --armor --output tmp.gpg thy
rsync some:tmp.gpg .
gpg2 --import tmp.gpg; rm tpm.gpg
# rm ~/.gnupg/trustdb.gpg
ssh some gpg2 --export-ownertrust | gpg2 --import-ownertrust
```

# take care of ssh-agent

```bash
(
	cd ~/usr/extern;
	git clone git@github.com:wwalker/ssh-find-agent.git wwalker/ssh-find-agent;
	ln -s wwalker/ssh-find-agent;
)

```

## remote servers

When using emacs daemon on remote server you usually forward your
ssh-agent because the remote node as no agent, neither has it your
keys.

```bash
ssh -A remote emacsclient -s emacs-session -nw
```

Or via `screen`

```
ssh -At remote screen -RdS screen-session
```

## remote desktops

When using emacs daemon on a remote desktop where a use session may be
active the mix of forwarded agents and local agents may become
confusing.

```bash
ssh -AX remote emacsclient -s session -c
```

And the `shell` buffers may use dead or not up-to-date different remote agents.

So you may choose to not forward your local desktop agent

```bash
ssh -X remote emacsclient -s session -c
```

and [ssh-find-agent](https://github.com/wwalker/ssh-find-agent) can help.

As simple oneliners:

```bash
ls /tmp/ssh-*/* | cut -d. -f2 | xargs ps;
ls /tmp/ssh-*/* | xargs -i echo env SSH_AUTH_SOCK={} ssh-add -l;
ls /tmp/ssh-*/* | xargs -i echo export SSH_AUTH_SOCK={};
```

# Install Samsung SL-M3320ND

- Redo what we learned previously, with changes

```bash
  echo deb http://www.bchemnet.com/suldr/ debian extra > /etc/apt/sources.list.d/www.bchemnet.com.list

  gpg --keyserver pgpkeys.mit.edu --recv-key C95104E509BAC46D
  gpg -a --export C95104E509BAC46D | sudo apt-key add -

  wget http://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_2_all.deb
  dpkg -i suldr-keyring_2_all.deb

  aptitude update
  aptitude install suld-driver-4.01.17
```

- Add cups install

```bash
  aptitude install cups
  adduser thy lpadmin
```

- Use http://localhost:631/ and choose _val(Samsung M337x 387x 407x Series)
