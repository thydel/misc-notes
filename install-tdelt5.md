<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [sudo](#sudo)
- [SSH pub keys](#ssh-pub-keys)
- [SSH keys](#ssh-keys)
- [First packages](#first-packages)
- [Emacs](#emacs)
- [Chrome](#chrome)
- [Thunderbird](#thunderbird)
- [User in group staff](#user-in-group-staff)
- [Group staff control /usr/local](#group-staff-control-usrlocal)
- [Epiconcept setup](#epiconcept-setup)
    - [NetExtender](#netextender)
    - [OCS Inventory](#ocs-inventory)
        - [Install](#install)
        - [Run once](#run-once)
        - [Run every day](#run-every-day)
    - [Clamav](#clamav)
    - [UFW](#ufw)
        - [Setup](#setup)
        - [Show](#show)
    - [Audit script](#audit-script)
        - [Clone](#clone)
        - [Use](#use)
        - [Upload](#upload)
- [NVME](#nvme)
    - [Grub](#grub)
    - [Keep as secondary disk](#keep-as-secondary-disk)
        - [Crypttab](#crypttab)
    - [LVM](#lvm)
    - [Use FS](#use-fs)
- [Avoid Xorg problem](#avoid-xorg-problem)
- [Allow ssh as root](#allow-ssh-as-root)
- [Use NVME/home as home and SSD/home as spare](#use-nvmehome-as-home-and-ssdhome-as-spare)
- [Shortcuts via another lt](#shortcuts-via-another-lt)
- [Uses `package-activated-list` from an already configured workstation](#uses-package-activated-list-from-an-already-configured-workstation)
- [Get Helpers](#get-helpers)
- [Allows passwordless sudo during install](#allows-passwordless-sudo-during-install)
- [Pass and GPG](#pass-and-gpg)
    - [Install pass and get pass data](#install-pass-and-get-pass-data)
    - [Conf gpg-agent](#conf-gpg-agent)
    - [Get my GPG key](#get-my-gpg-key)
- [Chrome conf](#chrome-conf)
    - [Add Epiconcept person to chrome](#add-epiconcept-person-to-chrome)
    - [laucher](#laucher)
- [Permanent fix gnome-keyring nightmare](#permanent-fix-gnome-keyring-nightmare)
- [Vatious tools](#vatious-tools)
- [Ansible](#ansible)
- [Jc](#jc)
- [Compile last git](#compile-last-git)
- [Install acroread](#install-acroread)
- [Locales](#locales)
- [Fix thunderbird date format](#fix-thunderbird-date-format)
- [Too many dicts](#too-many-dicts)
- [chrome remote desktop](#chrome-remote-desktop)
    - [chrome-remote-desktop](#chrome-remote-desktop)
    - [xfce4](#xfce4)
- [chrome remote desktop session](#chrome-remote-desktop-session)
- [passi](#passi)

<!-- markdown-toc end -->

# sudo

```bash
su
```

Then

```bash
/usr/sbin/adduser thy sudo
exit
```

# SSH pub keys

From another node

```bash
ssh-copy-id tdelt5
```

# SSH keys

```bash
sudo aptitude install rsync
```

From another node

```bash
rsync -av  ~/.ssh/t.delamare@* tdelt5:.ssh
```

# First packages

```bash
sudo -s
```

Then

```bash
apt update
apt upgrade
apt full-upgrade
apt install htop hdparm
apt install aptitude
aptitude install apt-file
apt-file update
aptitude install screen make git ripgrep
aptitude install ccrypt elpa-ps-ccrypt
aptitude install openssh-server
```

# Emacs

```bash
sudo aptitude install emacs
```

```emacs
(require 'tls)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
```

[ErcSSL]:
	https://www.emacswiki.org/emacs/ErcSSL
	"emacswiki.org"

[MELPA Getting started]:
    https://melpa.org/#/getting-started
    "/melpa.org"

# Chrome

```bash
sudo aptitude install wget
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

# Thunderbird

```bash
sudo aptitude install thunderbird
```

# User in group staff

```bash
sudo add-user thy staff
exit
```

# Group staff control /usr/local

```
find /usr/local -type d | xargs sudo chgrp staff
find /usr/local -type d | xargs sudo chmod g+ws
```

# Epiconcept setup

## NetExtender

```bash
mkdir -p /usr/local/dist
wget https://software.sonicwall.com/NetExtender/NetExtender.Linux-10.2.817.x86_64.tgz
mv NetExtender.Linux-10.2.817.x86_64.tgz /usr/local/dist
(cd /usr/local; tar zxvf dist/NetExtender.Linux-10.2.817.x86_64.tgz)
(cd /usr/local; mv netExtenderClient netExtenderClient-10.2.817)
(cd /usr/local; ln -s netExtenderClient-10.2.817 netExtenderClient)
(cd /usr/local/netExtenderClient; sudo ./install) # "Set pppd to run as root [y/N]?" y
/usr/sbin/netExtender -u t.delamare -d epiconcept.vpn 178.20.49.59:4433
```

## OCS Inventory

### Install

```bash
sudo aptitude install ocsinventory-agent # OCS Inventory server URL: 192.168.33.120
```

### Run once

```console
thy@tdelt5:~$ echo logfile=/var/log/ocsinventory-agent.log | sudo tee -a /etc/ocsinventory/ocsinventory-agent.cfg
logfile=/var/log/ocsinventory-agent.log
thy@tdelt5:~$ sudo cat /etc/ocsinventory/ocsinventory-agent.cfg
server=192.168.33.120
logfile=/var/log/ocsinventory-agent.log
thy@tdelt5:~$ sudo -E ocsinventory-agent
thy@tdelt5:~$ 
thy@tdelt5:~$ cat /var/log/ocsinventory-agent.log
[Wed Jan  6 22:59:27 2021][info] Accountinfo file doesn't exist. I create an empty one.
[Wed Jan  6 22:59:27 2021][info] PROLOG_FREQ has changed since last process(old=,new=24)
[Wed Jan  6 22:59:27 2021][info] [download] Download is off.
[Wed Jan  6 22:59:31 2021][info] [download] Beginning work. I am 29346.
[Wed Jan  6 22:59:31 2021][info] [download] Option turned off. Exiting.
```

### Run every day

```bash
echo '0 12 * * * root ocsinventory-agent' | sudo tee /etc/cron.d/ocsinventory-agent
```

## Clamav

```bash
sudo aptitude install clamav-daemon
sudo service clamav-daemon start
sudo adduser thy clamav
sudo adduser thy adm
exit
```

## UFW

### Setup

```bash
sudo aptitude install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow from 192.168.44.0/24 to 224.0.0.0/24
sudo ufw allow from 192.168.45.0/24 to 224.0.0.0/24
sudo ufw allow from 192.168.46.0/24 to 224.0.0.0/24
sudo ufw enable
```

### Show

```console
thy@tdelt5:~$ sudo ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
224.0.0.0/24               ALLOW IN    192.168.44.0/24
224.0.0.0/24               ALLOW IN    192.168.45.0/24
22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

## Audit script

use [epiconcept-workstations][]

### Clone

```bash
env GIT_SSH_COMMAND='ssh -i ~/.ssh/t.delamare@epiconcept.fr -F /dev/null' git clone git@github.com:Epiconcept-Paris/epiconcept-workstations.git Epiconcept-Paris/epiconcept-workstations
```

### Use

```bash
./auditws.sh
```

[epiconcept-workstations]:
    https://github.com/Epiconcept-Paris/epiconcept-workstations
    "github.com repo"

### Upload

in 'Shared with me > Linux > TDE'

# NVME

- Add a `Samsung SSD 970 EVO 500GB` NVME SSD
- Reinstall `debian10`
- Fail to boot

## Grub

Edit `/etc/default/grub`

```bash
echo GRUB_TIMEOUT_STYLE=menu | sudo tee -a /etc/default/grub
echo 'GRUB_CMDLINE_LINUX_DEFAULT=""' | sudo tee -a /etc/default/grub
echo GRUB_ENABLE_CRYPTO=y | sudo tee -a /etc/default/grub
sudo update-grub
```

## Keep as secondary disk

### Crypttab

```bash
echo nvme0n1p5_crypt UUID=86d78997-5704-4f85-bd6c-141e7b59f00e none luks,discard | sudo tee -a /etc/crypttab
sudo cryptdisks_start nvme0n1p5_crypt
echo cryptdisks_start nvme0n1p5_crypt | sudo tee -a /etc/local/README
```

## LVM

We have two `Volume group` with the same name

Use `vgdisplay` to find `VG UUID` with `VG Size` matching NVME

```bash
vgdisplay
```

And rename using UUID

```bash
vgrename i1Zfaz-RXui-2dTe-DFWN-9Lbu-ZEI1-rQqEtK tdelt5-vg2
```

Activate all LV

```bash
vgchange -a y tdelt5-vg2
```

## Use FS

```bash
mkdir ~/usr
echo /dev/mapper/tdelt5--vg2-home /home/thy/usr ext4 noauto,defaults 0 0 | sudo tee -a /etc/fstab
sudo fsck /dev/mapper/tdelt5--vg2-home
echo fsck /dev/mapper/tdelt5--vg2-home | sudo tee -a /etc/local/README
sudo mount /home/thy/usr
echo mount /home/thy/usr | sudo tee -a /etc/local/README

sudo mkdir -p /mnt/{tmp,spl,nvme/{boot,root,var,tmp}}

echo /dev/nvme0n1p1 /mnt/nvme/boot ext2 noauto,defaults 0 0 | sudo tee -a /etc/fstab
sudo mount /mnt/nvme/boot

echo /dev/mapper/tdelt5--vg2-root /mnt/nvme/root ext4 noauto,defaults 0 0 | sudo tee -a /etc/fstab
sudo mount /mnt/nvme/root

echo /dev/mapper/tdelt5--vg2-var /mnt/nvme/var ext4 noauto,defaults 0 0 | sudo tee -a /etc/fstab
sudo mount /mnt/nvme/var

echo /dev/mapper/tdelt5--vg2-tmp /mnt/nvme/tmp ext4 noauto,defaults 0 0 | sudo tee -a /etc/fstab
sudo mount /mnt/nvme/tmp
```

# Avoid Xorg problem

To avoid `/var/log/Xorg.0.log` to be filled by

```
(EE) modeset(0): Failed to get GBM bo for flip to new front.
modeset(0): present flip failed
```

And while no better workaround found

Disable `Enable software compositing window manager` in `System / Prefrences / Look and Feel / Windows`

Alternative

```bash
aptitude install mate-tweak
```

And select `Marco no compositer` in `System / Prefrences / Look and FEEL / Mate Tweak / Windows / Window Manager`

[Bug 1645553 - Failed to get GBM bo for flip to new front... spamming forever on my logs]:
    https://bugzilla.redhat.com/show_bug.cgi?id=1645553
    "redhat.com"

# Allow ssh as root

```bash
rsync -av ~/.ssh /root
chown -R root.root /root/.ssh/
```

# Use NVME/home as home and SSD/home as spare

```bash
umount /home/thy/usr
mount /dev/mapper/tdelt5--vg2-home /mnt/spl
rsync -avH /home/ /mnt/spl
umount /home
umount mnt/spl
aptitude install ed
echo -e '/.thy.usr/s///\nwq' | ed /etc/fstab
mount /home
lvrename tdelt5-vg home spare
echo -e '/tdelt5--vg-home/s/home/spare/g\nwq' | ed /etc/fstab
mkdir /spare
mount /spare
```

# Shortcuts via another lt

```bash
rsync -avH tdelt3:.thy ~/
echo 'if [ -f ~/.thy/bashrc ]; then . ~/.thy/bashrc; fi' >> ~/.bashrc
```

```bash
rsync -avH tdelt3:usr ~/
```

```bash
(cd ~/.ssh; ln -s ssh-config config)
```

Copy-paste parts of /etc/hosts

```bash
ssh tdelt3 sudo adduser root ssh
sudo -E rsync -av root@tdelt3.eth:/etc/local /etc
```

```bash
rsync tdelt3:.gitconfig ~/
```

```bash
sudo -E rsync -aHuv root@tdelt3.eth:/usr/local/ /usr/local
```

# Uses `package-activated-list` from an already configured workstation

Previously done, works no more, Follow [ELPA Failing to Load Packages][]

```bash
emacsclient -s $USER --eval '(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")'
```

Then as usual

```bash
list () { ssh ${1:?} env TMPDIR=/var/tmp emacsclient -s $USER --eval package-activated-list | tr -d '()'; }
norm () { fmt -1 | sort; }
install () { xargs -i echo $'emacsclient -s $USER --eval "(package-install \'{})"'; }
list tdelt3 | norm | install | dash
```

[ELPA Failing to Load Packages]:
    https://irreal.org/blog/?p=8243
    "irreal.org"

# Get Helpers

```bash
(cd ~/usr/thydel.d/helpers; ./helper.mk install)
```

# Allows passwordless sudo during install

```
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

# Pass and GPG

## Install pass and get pass data

```bash
sudo aptitude install pass
(cd; ln -s /home/thy/usr/perso.d/pass-store .password-store)
pass git status
```
## Conf gpg-agent

```bash
sudo aptitude install pinentry-curses pinentry-tty
echo pinentry-program /usr/bin/pinentry-tty >> ~/.gnupg/gpg-agent.conf
echo default-cache-ttl $((3600 * 24)) >> ~/.gnupg/gpg-agent.conf
echo max-cache-ttl $((3600 * 24 * 7)) >> ~/.gnupg/gpg-agent.conf
```

## Get my GPG key

https://www.debuntu.org/how-to-importexport-gpg-key-pair/

```bash
ssh $some gpg --export --armor $USER | gpg --import
ssh -t $some gpg --export-secret-keys --armor --output tmp.gpg $USER
rsync $some:tmp.gpg .
gpg --import tmp.gpg; rm tmp.gpg; ssh $some rm tmp.gpg
# rm ~/.gnupg/trustdb.gpg
ssh $some gpg --export-ownertrust | gpg --import-ownertrust
```

# Chrome conf

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

# Permanent fix gnome-keyring nightmare

Not yet, wait and see if still required, intead

```bash
echo -e '/^export SSH_AUTH_SOCK/s/^/#/\nwq' | ed ~/.thy/bashrc
```

```bash
cd ~/usr/thydel.d/misc-play
helper ansible
user-ssh-agent.yml
systemctl --user enable user-ssh-agent
systemctl --user start user-ssh-agent
```

# Vatious tools

```bash
sudo aptitude install make-doc curl autoconf asciidoc pandoc
```

# Ansible

```bash
mkdir -p ~/.ansible
rsync -avn tdelt3:.ansible/collections .ansible
sudo aptitude install python3-yaml python3-jinja2 python-apt
sudo aptitude install python3-pip
pip3 install pycrypto
(cd /usr/local/bin; ln -s /usr/bin/python3 python)
```

# Jc

```bash
sudo -H pip3 install jc
jc -a | jq
```

# Compile last git

Get latest version

```bash
git clone git@github.com:git/git.git
sudo aptitude install curl
last-tag () { curl --silent https://api.github.com/repos/${1:?}/tags | jq -r .[].name | sort -V | tail -1; }
last-tag git/git | xargs -i git -C git checkout -b compile {}
```

Deps

```console
thy@tdelt5:~$ cat /etc/debian_version 
10.8
```

```bash
sudo aptitude install zlib1g-dev libssl-dev libcurl4-openssl-dev libexpat1-dev gettext docbook2x asciidoc
```

Then as usual

```bash
cd git
sudo aptitude install autoconf
make configure
./configure --prefix=/usr/local
make all doc info
sudo make install install-doc install-html install-info
```

```console
thy@tdelt5:~$ /usr/bin/git --version
git version 2.20.1
thy@tdelt5:~$ type git
git is hashed (/usr/local/bin/git)
thy@tdelt5:~$ git --version
git version 2.30.1
```

# Install acroread

```bash
wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
sudo dpkg --add-architecture i386
sudo aptitude update
which gdebi || sudo aptitude install gdebi
sudo aptitude install libxml2:i386 libstdc++6:i386
sudo gdebi -n AdbeRdr9.5.5-1_i386linux_enu.deb
```

# Locales

```bash
echo -e '/^# fr_FR.UTF-8/s/^# //\nwq' | sudo ed /etc/locale.gen
add () { local f=/etc/locale.gen; grep -q ^${1:?} $f || echo -e "/^# $1/s/^# //\nwq" | sudo ed $f; }
add fr_FR.UTF-8
add en_DK.UTF-8
```

# Fix thunderbird date format

[Date display format]:
	http://kb.mozillazine.org/Date_display_format "mozillazine.org"

See [Date display format][]

```
env LC_TIME=en_DK.UTF.8 thunderbird
```

# Too many dicts

```bash
edit-func () { : ${3:?}; source <(declare -f $1 | sed -e s_{$2}_$3_); }

nocache () { rm -f ~/tmp/.cache/${1:?}; }
cache () (
  set -euo pipefail;
  local n=$1;
  shift;
  local d=~/tmp/.cache;
  local f=$d/$n;
  mkdir -p $d;
  if test -f $f; then cat $f; else $n "$@" | tee $f; fi;
)

list-inst-with () { apt-file search -l ${1:?} | sed -e s/^/~i/ | xargs -r aptitude -F %p search; }
cache list-inst-with /var/lib/dictionaries-common
cache list-inst-with /var/lib/dictionaries-common | grep aspell | grep -v -e aspell-en -e aspell-fr | xargs sudo aptitude remove -y

aptitude search -F%p ^hunspell-~i | grep -v -e hunspell-fr -e hunspell-en | xargs sudo aptitude remove -y
aptitude search -F%p ^myspell-~i | grep -v -e myspell-fr -e myspell-en -e myspell-uk | xargs sudo aptitude remove -y

list-inst-with /usr/lib/thunderbird/extensions/langpack
```

# chrome remote desktop

## chrome-remote-desktop

```
sudo mkdir -p /usr/local/dist
sudo aptitude install proot
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
```

# passi

```bash
passi () { env PASSWORD_STORE_GIT=~/.password-store-infra PASSWORD_STORE_DIR=~/.password-store-infra/password-store pass "$@"; }
passi keepass_admin/Backup/backup01_iDRAC
```

# Printer Epson xp-2100

```bash
sudo aptitude install cups
sudo adduser $USER lpadmin
sudo aptitude install printer-driver-all
sudo aptitude install system-config-printer
```

- See [Epson L3110 on Ubuntu 20.04 LTS][]
- Use [epson.net][] to search `xp-2100`
- Get `epson-inkjet-printer-escpr_1.7.9-1lsb3.2_amd64.deb`
- Get `epson-printer-utility_1.1.1-1lsb3.2_amd64.deb`
- get [lsb-compat][] from [packages.debian.org][]

```bash
d=/usr/local/dist
f=lsb-compat_9.20161125_amd64.deb
test -f $d/$f || proot -w $d http://ftp.debian.org/debian/pool/main/l/lsb/$f
```

```bash
cd /usr/local/dist
sudo apt install ./lsb-compat_9.20161125_amd64.deb
sudo apt install ./epson-printer-utility_1.1.1-1lsb3.2_amd64.deb
sudo apt install ./epson-inkjet-printer-escpr_1.7.9-1lsb3.2_amd64.deb
```

[lsb-compat]:
    http://ftp.debian.org/debian/pool/main/l/lsb/lsb-compat_9.20161125_amd64.deb
    "ftp.debian.org"

[packages.debian.org]:
    https://packages.debian.org/stretch/amd64/lsb-compat/download
    "packages.debian.org"

[Epson L3110 on Ubuntu 20.04 LTS]:
    https://askubuntu.com/questions/1250554/epson-l3110-on-ubuntu-20-04-lts
    "askubuntu.com"

[epson.net]:
    https://download.ebz.epson.net/dsc/search/01/search/searchModule
    "epson.net"

# X11 broken after upgrade and reboot

```
Fatal server error:
[    86.760] (EE) Cannot run in framebuffer mode. Please specify busIDs        for all framebuffer devices
```

## Try backports

```bash
echo deb http://deb.debian.org/debian buster-backports main non-free contrib | sudo tee -a /etc/apt/sources.list
sudo aptitude update
aptitude search -t $(lsb_release -sc)-backports -F '%p %v -> %V' '~U ~Abackports linux-image-amd64'

sudo aptitude remove linux-image-4.19.0-13-amd64

sudo aptitude install -t $(lsb_release -sc)-backports linux-image-amd64 linux-headers-amd64
aptitude search -t $(lsb_release -sc)-backports -F %p '~U ~Abackports firmware' | xargs sudo sudo aptitude install -t $(lsb_release -sc)-backports -y
```

# imagemagick - convert not allowed

- [imagemagick - convert not allowed][]
- [override default ImageMagick policy.xml][]

[imagemagick - convert not allowed]:
    https://askubuntu.com/questions/1127260/imagemagick-convert-not-allowed
    "askubuntu.com"

[override default ImageMagick policy.xml]:
    https://stackoverflow.com/questions/52703123/override-default-imagemagick-policy-xml
    "stackoverflow.com"

[Local Variables:]::
[indent-tabs-mode: nil]::
[End:]::
