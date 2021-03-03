<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Got a tmp desktop](#got-a-tmp-desktop)
- [Makes an installable USB key](#makes-an-installable-usb-key)
- [Default install as usual](#default-install-as-usual)
- [first remote steps](#first-remote-steps)
    - [install key](#install-key)
- [First local steps](#first-local-steps)
    - [sudo](#sudo)
- [Allow remote cryproot-unlock](#allow-remote-cryproot-unlock)
- [More remote steps](#more-remote-steps)
    - [install emacs](#install-emacs)
    - [find MAC (3c:d9:2b:61:10:df)](#find-mac-3cd92b6110df)
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
- [++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++](#)
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
- [pass and GPG](#pass-and-gpg)
    - [Install pass and get pass data](#install-pass-and-get-pass-data)
    - [Conf gpg-agent](#conf-gpg-agent)
    - [Get my GPG key, stretch](#get-my-gpg-key-stretch)
- [Uses emacs `package-activated-list` from an already configured workstation](#uses-emacs-package-activated-list-from-an-already-configured-workstation)
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
- [Use autossh to start a reverse ssh tunnel](#use-autossh-to-start-a-reverse-ssh-tunnel)

<!-- markdown-toc end -->

# Got a tmp desktop

# Makes an installable USB key

```
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.7.0-amd64-netinst.iso
cp debian-9.57.0-amd64-netinst.iso /dev/sd$usbkeyid
```

# Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Partioning
  - step 1 fdisk part
    - small boot part ~250M as /dev/sda1 /boot
    - extended part with rest of disk /dev/sda2
    - 10% of disk as /dev/sda5 for first crypted LVM
    - rest of free space as /dev/sda6 for second crypted LVM
  - step 2 luks crypted parts
    - create sda5_crypt on top of /dev/sda5 using pwd1
    - create sda6_crypt on top of /dev/sda6 using pwd2
  - step 3 LVM part on top of crypted part
     - create tdews3-vg1 on sda5_crypt
     - create tdews3-vg2 ob sda6_crypt
  - step 4 linux part on top of LVM
     - create root ~50%, var ~20% and tmp ~5% on tdews3-vg1
     - create swap ~200% memsize, home ~45% and local ~45% on tdews3-vg2
- Install xfce, Mate, sshd

# First local step

```bash
su
apt install openssh-server
```

# first remote steps

## install key

```
ssh-copy-id -i ~/.ssh/t.delamare@epiconcept.fr tdews3
ssh-copy-id -i ~/.ssh/t.delamare@laposte.net tdews3
```

# First local steps

Maybe after `ssh tdews3`

## sudo

Login using mate and use `su` add us to `sudo` group
```
export u=$USER
su
/usr/sbin/adduser $u sudo
exit
mate-session-save --logout
```

Login again to use `sudo`

Allows passwordless sudo during install
```
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

Use my dotfiles when in sudo
```
echo "Defaults:$USER env_keep += HOME" | sudo tee -a /etc/sudoers.d/$USER
```

Install `aptitude`, `deborphan` and `apt-file`
```
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
sudo apt full-upgrade
sudo apt install aptitude
echo 'aptitude update; aptitude full-upgrade -y' | sudo dash
echo 'aptitude install -y deborphan; deborphan' | sudo dash
deborphan
deborphan | sudo aptitude -y remove
echo 'aptitude install -y apt-file; apt-file update' | sudo dash
```

# Allow remote cryproot-unlock

```
sudo aptitude install busyox dropbear dropbear-initramfs rsync
sudo rsync -av ~/.ssh/authorized_keys /etc/dropbear-initramfs
sudo update-initramfs -u
```

From my ws
```
sh -o StrictHostKeyChecking=no -l root tdews3 cryproot-unlock
```

# More remote steps

## install emacs

```
ssh tdews3 sudo aptitude install emacs25-lucid
```


## find MAC (3c:d9:2b:61:10:df)

Parse `lshw` output with [find-eth-name](find-eth-name.jq) `jq`
script


```
ssh tdews3 sudo aptitude install lshw ethtool
ssh tdews3 sudo lshw -json | find-eths-names.jq
```
# Usual DHCP and DNS setup

# Add and use `x2x` from main WS

```
ssh tdews3 sudo aptitude install x2x
ssh -XC tdews3 x2x -east -to :0 # if lt right of ws
ssh -XC tdews3 x2x -west -to :0 # lt lt left  of ws
```

# Install some packages

## Setup apt sources

```
ssh tdews3 sudo aptitude install ed
echo -e 'g/^[^#].*main/s/main/main contrib non-free/\nwq' | ssh tdews3 sudo ed /etc/apt/sources.list
ssh tdews3 sudo aptitude update
ssh tdews3 sudo aptitude install firmware-linux
```

## Fix missing firmware

```
ssh tdews3 sudo grep firmware /var/log/kern.log | grep -i -e failed -e error
: list-missing-firmware-file | ssh tdews3 xargs apt-file search {}
: list-missing-firmware-pkg  | xargs aptitude install {}
```

Note:

> `list-missing-firmware-file` and `list-missing-firmware-pkg` are fictive commands

```
: ssh tdelt4 sudo aptitude install firmware-misc-nonfree firmware-realtek
: ssh tdews3 sudo aptitude install firmware-amd-graphics
```

## Basic install

```
ssh tdews3 sudo aptitude install htop hdparm net-tools proot
ssh tdews3 sudo aptitude install -y thunderbird thunderbird-l10n-fr thunderbird-enigmail
```

## Install required tools

```
ssh tdews3 sudo aptitude install -y netcat-openbsd git rsync make make-doc screen
```

## Install requires libs

### ansible

```
ssh tdews3 sudo aptitude install -y python-yaml python-jinja2 python-paramiko python-apt
ssh tdews3 sudo aptitude install -y python-pip
: ssh tdelt4 sudo -H pip install pycrypto
```

## Install chrome

On `tdews3`
```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo deb http://dl.google.com/linux/chrome/deb/ stable main | sudo tee -a /etc/apt/sources.list.d/google.list
sudo aptitude update
sudo aptitude install -y google-chrome-stable
```

## Install acroread

On `tdews3`
```
# wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
wget https://github.com/chili-epfl/acroread-deb/blob/master/AdbeRdr9.5.5-1_i386linux_enu.deb?raw=true
mv 'AdbeRdr9.5.5-1_i386linux_enu.deb?raw=true' AdbeRdr9.5.5-1_i386linux_enu.deb
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
sudo aptitude install gdebi
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

sudo service chrome-remote-desktop start

echo to enable remote connection
echo Use https://chrome.google.com/webstore/detail/chrome-remote-desktop/gbchcmhmhahfdphkhkmpfmihenigjmpp
```

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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
