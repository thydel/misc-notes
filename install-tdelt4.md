<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Got a new old laptop](#got-a-new-old-laptop)
- [Makes an installable USB key](#makes-an-installable-usb-key)
- [Default install as usual](#default-install-as-usual)
- [first remote steps](#first-remote-steps)
    - [install key](#install-key)
- [First local steps](#first-local-steps)
    - [sudo](#sudo)
- [More remote steps](#more-remote-steps)
    - [install emacs](#install-emacs)
    - [find MAC (20:cf:30:15:c4:2f)](#find-mac-20cf3015c42f)
- [Usual DHCP and DNS setup](#usual-dhcp-and-dns-setup)
- [Add and use `x2x` from main WS](#add-and-use-x2x-from-main-ws)
- [Install some packages](#install-some-packages)
    - [Setup apt sources](#setup-apt-sources)
    - [Fix missing firmware](#fix-missing-firmware)
    - [Basic install](#basic-install)
    - [Install required tools](#install-required-tools)
    - [Install requires libs](#install-requires-libs)
        - [ansible](#ansible)
    - [Install chrome](#install-chrome)
    - [Install acroread](#install-acroread)
- [chrome remote desktop](#chrome-remote-desktop)
    - [chrome-remote-desktop](#chrome-remote-desktop)
    - [xfce4](#xfce4)
- [chrome remote desktop session](#chrome-remote-desktop-session)
- [Fix ayh9k nightmare](#fix-ayh9k-nightmare)
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
- [permanent fix gnome-keyring nightmare](#permanent-fix-gnome-keyring-nightmare)
- [Install ssh-config](#install-ssh-config)
- [Get epi repositories](#get-epi-repositories)
    - [Get bootstrap dir](#get-bootstrap-dir)
    - [Get all repositories](#get-all-repositories-1)
- [Install screen configs](#install-screen-configs)
- [pass and GPG](#pass-and-gpg)
    - [Install pass and get pass data](#install-pass-and-get-pass-data)
    - [Conf gpg-agent](#conf-gpg-agent)
    - [Get my GPG key, stretch](#get-my-gpg-key-stretch)
- [Uses emacs `package-activated-list` from an already configured workstation](#uses-emacs-package-activated-list-from-an-already-configured-workstation)
- [Minimal sshd config](#minimal-sshd-config)
- [++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++](#)
- [Chrome conf](#chrome-conf)
    - [GSTM](#gstm)
    - [Proxy helper](#proxy-helper)
    - [Add Epiconcept person to chrome](#add-epiconcept-person-to-chrome)
    - [laucher](#laucher)
- [Use autossh to start a reverse ssh tunnel](#use-autossh-to-start-a-reverse-ssh-tunnel)

<!-- markdown-toc end -->

# Got a new old laptop

See [K50IJ][] and [Asus K50IJ-BNC5 Specs][]

[K50IJ]: https://www.asus.com/Laptops/K50IJ/specifications/ "asus.com"

[Asus K50IJ-BNC5 Specs]: https://www.cnet.com/products/asus-k50ij-bnc5/specs/ "cnet.com"

Replace rotational disk by an SSD one

[How to disassemble Asus K series]:
	http://www.insidemylaptop.com/disassemble-asus-k-series-notebook/ "insidemylaptop.com"

# Makes an installable USB key

```
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.5.0-amd64-netinst.iso
cp debian-9.5.0-amd64-netinst.iso /dev/sd$usbkeyid
```

# Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Use whole disk
  - root, var, tmp, home part
  - Use encrypted LVM
- Install xfce, Mate, sshd

# first remote steps

## install key

```
ssh-copy-id -i ~/.ssh/t.delamare@laposte.net tdelt4
```

# First local steps

Maybe after `ssh tdelt4`

## sudo

Login using mate and use `su` add us to `sudo` group
```
export u=$USER
su
adduser $u sudo
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

Install `aptitude`, `deborphan` and `apt-file`
```
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
sudo apt install aptitude
echo 'aptitude update; aptitude full-upgrade' | sudo dash
echo 'aptitude install -y deborphan; deborphan' | sudo dash
echo 'aptitude install -y apt-file; apt-file update' | sudo dash
```

# More remote steps

## install emacs

```
ssh tdelt4 sudo aptitude install emacs25-lucid
```


## find MAC (20:cf:30:15:c4:2f)

Parse `lshw` output with [find-eth-name](find-eth-name.jq) `jq`
script


```
ssh tdelt4 sudo aptitude install lshw ethtool
ssh tdelt4 sudo lshw -json | find-eths-names.jq
```
# Usual DHCP and DNS setup

# Add and use `x2x` from main WS

```
ssh tdelt4 sudo aptitude install x2x
ssh -XC tdelt4 x2x -east -to :0 # if lt right of ws
ssh -XC tdelt4 x2x -west -to :0 # lt lt left  of ws
```

# Install some packages

## Setup apt sources

```
ssh tdelt4 sudo aptitude install ed
echo -e 'g/^[^#].*main/s/main/main contrib non-free/\nwq' | ssh tdelt4 sudo ed /etc/apt/sources.list
ssh tdelt4 sudo aptitude update
ssh tdelt4 sudo aptitude install firmware-linux
```

## Fix missing firmware

```
ssh tdelt4 sudo grep firmware /var/log/kern.log | grep failed
: list-missing-firmware-file | ssh tdelt4 xargs apt-file search {}
: list-missing-firmware-pkg  | xargs aptitude install {}
```

Note:

> `list-missing-firmware-file` and `list-missing-firmware-pkg` are fictive commands

```
: ssh tdelt4 sudo aptitude install firmware-misc-nonfree firmware-realtek
```

## Basic install

```
ssh tdelt4 sudo aptitude install htop hdparm net-tools proot
ssh tdelt4 sudo aptitude install -y thunderbird thunderbird-l10n-fr # thunderbird-enigmail
```

## Install required tools

```
ssh tdelt4 sudo aptitude install -y netcat-openbsd git rsync make make-doc screen
```

## Install requires libs

### ansible

```
ssh tdelt4 sudo aptitude install -y python-yaml python-jinja2 python-paramiko python-apt
ssh tdelt4 sudo aptitude install -y python-pip
: ssh tdelt4 sudo -H pip install pycrypto
```

## Install chrome

On `tdelt4`
```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo deb http://dl.google.com/linux/chrome/deb/ stable main | sudo tee -a /etc/apt/sources.list.d/google.list
sudo aptitude update
sudo aptitude install -y google-chrome-stable
```

## Install acroread

On `tdelt4`
```
wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
sudo dpkg --add-architecture i386
sudo aptitude update
which gdebi || sudo aptitude install -y gdebi
sudo aptitude install -y libxml2:i386 libstdc++6:i386
sudo gdebi -n AdbeRdr9.5.5-1_i386linux_enu.deb
```

# chrome remote desktop

## chrome-remote-desktop

```
sudo mkdir -p /usr/local/dist
sudo proot -w /usr/local/dist wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo gdebi --non-interactive  /usr/local/dist/chrome-remote-desktop_current_amd64.deb
```

## xfce4

If `xfce` was not choosen during install

```
sudo aptitude install xfce4
sudo aptitude install xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-datetime-plugin xfce4-goodies xfce4-netload-plugin xfce4-places-plugin xfce4-terminal xfce4-xkb-plugin
```

# chrome remote desktop session

```
sudo adduser $USER chrome-remote-desktop
echo 'env -u DBUS_SESSION_BUS_ADDRESS xfce4-session' > ~/.chrome-remote-desktop-session

crdd=/opt/google/chrome-remote-desktop
sudo proot -w $crdd cp -p chrome-remote-desktop{,.00}
ed='/^DEFAULT_SIZE_NO_RANDR/s/^/#/\na\nDEFAULT_SIZE_NO_RANDR = "1920x1080"\n.\nwq'
echo -e $ed | sudo proot -w $crdd ed chrome-remote-desktop

sudo ln -ls /usr/bin/Xvfb /usr/bin/Xvfb-randr

sudo service chrome-remote-desktop start

echo to enable remote connection
echo Use https://chrome.google.com/webstore/detail/chrome-remote-desktop/gbchcmhmhahfdphkhkmpfmihenigjmpp
```

# Fix ayh9k nightmare

- [Thread: Atheros AR9485 ath9k connectivity problems][]
- [exemples-d-utilisation-de-nmcli][]

```
echo "options ath9k nohwcrypt=1" | sudo tee -a /etc/modprobe.d/ath9k.conf
echo ath9k | sudo tee -a /etc/modules
```

[exemples-d-utilisation-de-nmcli]:
	https://debian-facile.org/doc:reseau:network-manager#exemples-d-utilisation-de-nmcli "debian-facile.org"

[Thread: Atheros AR9485 ath9k connectivity problems]:
	https://ubuntuforums.org/showthread.php?t=2233283 "ubuntuforums.org"

# Use staff group

On `tdelt4`
```
sudo adduser $USER staff
newgrp staff
newgrp $USER
```

# Temporarily fix gnome-keyring nightmare

On `tdelt4`
```
ssh-agent > /tmp/.ssha
. /tmp/.ssha
```

On `tdelt4`

# Get private stuff

```
echo -e 'Match OriginalHost git.$tld\n  HostName $hostname\n  Port $port' | tee -a ~/.ssh/config
perso=git.$tld

(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:$(pwd)/private.git;
	ln -s private/perso.mk Makefile;
	make perso;
)
```

# Get my repositories

On `tdelt4`

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

On `tdelt4`

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
(cd ~/usr/ext; git clone --branch stable-2.7 --recursive git://github.com/ansible/ansible.git ansible-stable-2.7)
```

## Configure git

```
cd ~/usr/thydel.d/helpers
helper ansible
source ~/usr/ext/ansible-stable-2.7/hacking/env-setup -q
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

# Install ssh-config

```
make -C ~/usr/thydel.d/ssh-config make
proot -w ~/.ssh ln -s ssh-config config
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

# pass and GPG

On `tdelt4`

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

# Minimal sshd config

```
sudo adduser $USER ssh

echo PasswordAuthentication no | sudo tee -a /etc/ssh/sshd_config
echo AllowGroups ssh | sudo tee -a /etc/ssh/sshd_config
sudo service ssh restart
```

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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
