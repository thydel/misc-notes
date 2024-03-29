<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Got a new old desktop](#got-a-new-old-desktop)
- [Makes an installable USB key](#makes-an-installable-usb-key)
- [Default install as usual](#default-install-as-usual)
- [First local steps](#first-local-steps)
    - [sudo](#sudo)
- [first remote steps](#first-remote-steps)
    - [install key](#install-key)
    - [find MAC (7c:d3:0a:2f:c2:21)](#find-mac-7cd30a2fc221)
- [Usual DHCP and DNS setup](#usual-dhcp-and-dns-setup)
- [Add and use `x2x` from main WS](#add-and-use-x2x-from-main-ws)
- [install some packages](#install-some-packages)
    - [Setup apt sources](#setup-apt-sources)
    - [Fix missing firmware](#fix-missing-firmware)
    - [Basic install](#basic-install)
    - [Install required tools](#install-required-tools)
    - [Install requires libs](#install-requires-libs)
        - [ansible](#ansible)
    - [Install chrome](#install-chrome)
    - [Install acroread](#install-acroread)
- [Use staff group](#use-staff-group)
- [Temporarily fix gnome-keyring nightmare](#temporarily-fix-gnome-keyring-nightmare)
- [Get private stuff](#get-private-stuff)
- [Get my repositories](#get-my-repositories)
    - [Get Helpers](#get-helpers)
    - [Get all repositories](#get-all-repositories)
- [Install and use some local tools](#install-and-use-some-local-tools)
    - [`git-dates` require `propagate-date`](#git-dates-require-propagate-date)
    - [Install ansible simple way](#install-ansible-simple-way)
    - [Configure git](#configure-git)
    - [Install my bashrc, my dotemacs](#install-my-bashrc-my-dotemacs)
- [pass and GPG](#pass-and-gpg)
    - [Install pass and get pass data](#install-pass-and-get-pass-data)
    - [Conf gpg-agent](#conf-gpg-agent)
    - [Get my GPG key, stretch](#get-my-gpg-key-stretch)
- [Uses `package-activated-list` from an already configured workstation](#uses-package-activated-list-from-an-already-configured-workstation)
- [permanent fix gnome-keyring nightmare](#permanent-fix-gnome-keyring-nightmare)
- [Minimal sshd config](#minimal-sshd-config)
- [Get epi repositories](#get-epi-repositories)
    - [Get bootstrap dir](#get-bootstrap-dir)
    - [Get all repositories](#get-all-repositories-1)
- [Install ssh-config](#install-ssh-config)
- [Install screen configs](#install-screen-configs)
- [Chrome conf](#chrome-conf)
    - [GSTM](#gstm)
    - [Proxy helper](#proxy-helper)
    - [Add Epiconcept person to chrome](#add-epiconcept-person-to-chrome)
    - [laucher](#laucher)

<!-- markdown-toc end -->

# Got a new old desktop

See [HP 260 G2 Desktop Mini PC - Specifications][]

[HP 260 G2 Desktop Mini PC - Specifications]:
	https://support.hp.com/th-en/document/c05121551 "support.hp.com"

# Makes an installable USB key

```
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
adduser $USER sudo
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
sudo adduser $USER staff
newgrp staff
newgrp $USER
```

# Temporarily fix gnome-keyring nightmare

On `tdews2`
```
ssh-agent > /tmp/.ssha
. /tmp/.ssha
```

On `tdews2`
# Get private stuff

```
(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:$(pwd)/private.git;
	ln -s private/perso.mk Makefile;
	make perso;
)
```

# Get my repositories

On `tdews2`

## Get Helpers

```
echo -e 'Host *.github.com\nHostname github.com\n' >> ~/.ssh/config
echo -e 'Host thydel.github.com\nIdentityFile ~/.ssh/t.delamare@laposte.net\n'  >> ~/.ssh/config

mkdir -p ~/usr/thydel.d
git -C ~/usr/thydel.d clone git@thydel.github.com:thydel/helpers.git
(cd ~/usr/thydel.d/helpers; ./helper.mk install)
```

## Get all repositories

```
cd ~/usr/thydel.d
ln -s helpers/thydel.mk Makefile
make thydel
```

# Install and use some local tools

On `tdews2`

## `git-dates` require `propagate-date`

```
cd ~/usr/thydel.d/helpers
make -C ../propagate-date/ install
git-dates run dates
```

## Install ansible simple way

```
mkdir ~/usr/ext
use-ansible help
(cd ~/usr/ext; git clone --branch stable-2.5 --recursive git://github.com/ansible/ansible.git ansible-stable-2.5)
```

## Configure git

```
cd ~/usr/thydel.d/helpers
helper ansible
source ~/usr/ext/ansible-stable-2.5/hacking/env-setup -q
helper git-config
```

## Install my bashrc, my dotemacs

```bash
cd ~/usr/thydel.d/ar-my-bash-rc
helper ansible
bashrc-play.yml -i localhost, -c local -D
cd ~/usr/thydel.d/ar-my-dotemacs
dotemacs-play.yml -i localhost, -c local -D
```

# permanent fix gnome-keyring nightmare

```
cd ~/usr/thydel.d/misc-play
helper ansible
user-ssh-agent.yml
systemctl --user enable user-ssh-agent
systemctl --user start user-ssh-agent
```

# pass and GPG

On `tdews2`

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

## Get my GPG key, stretch

https://www.debuntu.org/how-to-importexport-gpg-key-pair/

```bash
ssh $some gpg2 --export --armor $USER | gpg2 --import
ssh -t $some gpg2 --export-secret-keys --armor --output tmp.gpg $USER
rsync $some:tmp.gpg .
gpg2 --import tmp.gpg; rm tmp.gpg; ssh $some rm tmp.gpg
# rm ~/.gnupg/trustdb.gpg
ssh $some gpg2 --export-ownertrust | gpg2 --import-ownertrust
```

# Uses emacs `package-activated-list` from an already configured workstation

```bash
emacsclient -s $USER --eval "(list-packages)"
ssh $from emacsclient -s $USER --eval package-activated-list | tr -d '()' | tr ' ' '\n' | sort -u \
| xargs -i echo $'emacsclient -s $USER --eval "(package-install \'{})"'
```

# Minimal sshd config

```
sudo adduser $USER ssh

echo PasswordAuthentication no | sudo tee -a /etc/ssh/sshd_config
echo AllowGroups ssh | sudo tee -a /etc/ssh/sshd_config
sudo service ssh restart
```

# Get epi repositories

## Get bootstrap dir

```
echo -e 'Host thyepi.github.com\nIdentityFile ~/.ssh/t.delamare@epiconcept.fr\n'  >> ~/.ssh/config

mkdir -p ~/usr/epipar.d
git -C ~/usr/epipar.d clone git@thyepi.github.com:Epiconcept-Paris/infra-plays.git
```

## Get all repositories

```
cd ~/usr/epipar.d
ln -s infra-plays/epipar.mk Makefile
make epipar
```

# Install ssh-config

# Install screen configs

Uses [ar-my-screenrc](https://github.com/thydel/ar-my-screenrc)

```
helper ansible
helper git-config
sudo aptitude install whois # for mkpasswd
screenrc-play.yml -i locahost, -c local -D
```

Uses [infra-thy](https://github.com/Epiconcept-Paris/infra-thy)

```
helper ansible # to install latest ansible
helper ansible/help # to install ansible-2.2 (for make all, aka dependencies)
make all
pass dummy
helper git-config
helper run dif init-play-dir vault_pass=vault/thy
sudo aptitude install whois # for mkpasswd
screen-remotes-oxa.yml -i localhost, -c local -DC # require ansible-2.4
screen-remotes.yml -i localhost, -c local -DC
```

# Chrome conf

## GSTM

```bash
sudo aptitude install gstm
```

Manual launcher setup `env SSH_AUTH_SOCK=/run/user/1000/user-ssh-agent.socket gstm`

Manually add entries from private repo

## Proxy helper

Configure proxy helper to use Socks for Epiconcpet account

## Add Epiconcept person to chrome

No non manual way currently known.

## laucher

```
google-chrome-beta --profile-directory=Default %U
google-chrome-beta --profile-directory='Profile 1' %U
```

Choose different icons for different profiles

```
mkdir /usr/local/share/icons
rsync -av ~/usr/perso.d/documents/icons/ /usr/local/share/icons
```

# Use autossh to start a reverse ssh tunnel

As `root`, assuming `revssh1` is as ssh host define in `/root/.ssh/config`

```
aptitude install autossh
mkdir -p /etc/autossh
proot -w /etc/autossh ssh-keygen -f revssh1-key
# copy /etc/autossh/revssh1-key.pub to revssh1
echo '#!/bin/bash' > /etc/autossh/revssh1
echo autossh -f revssh1 -R 22001:localhost:22 -N >> /etc/autossh/revssh1
chmod +x /etc/autossh/revssh1
echo -e '# -*- Mode: ssh-config; -*-\n\nHost revssh1' > /root/.ssh/config
echo -e '  Hostname h.d.t\n  User u\n  IdentityFile /etc/autossh/revssh1-key' >> /root/.ssh/config
```
