**got a new old desktop**

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Make a install usb key](#make-a-install-usb-key)
- [Default install as usual](#default-install-as-usual)
- [First local steps](#first-local-steps)
    - [sudo](#sudo)
- [first remote steps](#first-remote-steps)
    - [install key](#install-key)
    - [find MAC (64:31:50:12:2a:26)](#find-mac-643150122a26)
- [Usual DHCP and DNS setup](#usual-dhcp-and-dns-setup)

<!-- markdown-toc end -->

# Make a install usb key

```
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.1.0-amd64-netinst.iso
cp debian-9.1.0-amd64-netinst.iso /dev/sdX
```

# Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Use whole disk
  - root, var, tmp, home part
  - Use LVM
- Install all components

# First local steps

## sudo

Login using mate and use `su` add us to `sudo` group
```
su
adduser thy sudo
mate-session-save --logout
```

Login again to use `sudo`

```
sudo -s
apt-get install aptitude
aptitude update; aptitude full-upgrade
aptitude install deborphan; deborphan
```

Allows passwordless sudo during install
```
echo 'thy ALL=(ALL:ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/thy
```

Use my dotfiles when in sudo
```
echo 'Defaults:thy env_keep += HOME' | sudo tee -a /etc/sudoers.d/thy
```

# first remote steps

## install key
```
ssh-copy-id -i ~/.ssh/id_rsa -o PreferredAuthentications=password tdelt3
ssh tdelt3 sudo aptitude install emacs25-lucid
```

## find MAC (64:31:50:12:2a:26)

Parse `lshw` output with [find-eth-name](find-eth-name.jq) `jq`
script


```
ssh tdelt3 sudo aptitude install lshw jq ethtool
ssh tdelt3 sudo lshw -json | find-eth-name.jq | ssh tdelt3 sudo xargs ethtool -P
```

# Usual DHCP and DNS setup

# install some packages

## Basic install

```bash
sudo aptitude install htop
sudo aptitude install emacs
sudo aptitude install thunderbird
sudo aptitude install thunderbird-l10n-fr
```

## Install required tools

```bash
sudo aptitude install git
sudo aptitude install rsync
sudo aptitude install make make-doc
sudo aptitude install screen
```

## Install requires libs

```bash
sudo aptitude install python-yaml python-jinja2 python-paramiko # for ansible
```

## Install chrome

```bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo deb http://dl.google.com/linux/chrome/deb/ stable main | sudo tee -a /etc/apt/sources.list.d/google.list
sudo aptitude update
sudo aptitude install google-chrome-stable
```

## Install acroread

```bash
wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
sudo dpkg --add-architecture i386
sudo aptitude update
which gdebi || sudo aptitude install gdebi
sudo aptitude install libxml2:i386 libstdc++6:i386
sudo gdebi -n AdbeRdr9.5.5-1_i386linux_enu.deb
```

# Use staff group

```bash
sudo adduser thy staff
newgrp staff
newgrp thy
```

# Get private stuff

```bash
(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:usr/perso.d/private.git;
	ln -s private/perso.mk Makefile;
	make perso;
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
git-dates run dates
```

## Install ansible simple way

```bash
mkdir ~/usr/ext
use-ansible help
(cd ~/usr/ext; git clone --branch stable-2.4 --recursive git://github.com/ansible/ansible.git ansible-stable-2.4)
```

## Install my bashrc, my dotemacs

```bash
cd ~/usr/thydel.d/ar-my-bash-rc
helper ansible
bashrc-play.yml -i localhost, -c local -D
cd ~/usr/thydel.d/ar-my-dotemacs
dotemacs-play.yml -i localhost, -c local -D
```

# pass and GPG

## Install pass and get pass data

```bash
sudo aptitude install pass
# git -C ~/usr/perso.d clone pass-store
ln -s ~/usr/perso.d/pass-store ~/.password-store 
pass git status
```

## Conf gpg-agent

```bash
sudo aptitude install pinentry-curses pinentry-tty
echo pinentry-program /usr/bin/pinentry-tty >> ~/.gnupg/gpg-agent.conf
echo default-cache-ttl $((3600 * 24)) >> ~/.gnupg/gpg-agent.conf
echo max-cache-ttl $((3600 * 24 * 7)) >> ~/.gnupg/gpg-agent.conf
```

## Get my GPG key, jessie

```bash
ssh some gpg2 --export --armor thy | gpg2 --import
ssh -t some gpg2 --export-secret-keys --armor thy | gpg2 --import
ssh some gpg2 --export-ownertrust | gpg2 --import-ownertrust
```

## Get my GPG key, stretch

https://www.debuntu.org/how-to-importexport-gpg-key-pair/

```bash
ssh $some gpg2 --export --armor thy | gpg2 --import
ssh -t $some gpg2 --export-secret-keys --armor --output tmp.gpg thy
rsync $some:tmp.gpg .
gpg2 --import tmp.gpg; rm tmp.gpg
# rm ~/.gnupg/trustdb.gpg
ssh $some gpg2 --export-ownertrust | gpg2 --import-ownertrust
```

# GSTM

```bash
sudo aptitude install gstm
```
