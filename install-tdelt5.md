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
aptitude install screen make git
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

# Use in group staff

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


[Local Variables:]::
[indent-tabs-mode: nil]::
[End:]::
