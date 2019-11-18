# Got a new OVH vps

- Use OVH manager to reinstall with buster and my ssh key
- Use OVH manager to add a DNS entry for the new vps

## Rename host

```
ssh $vps -l root hostnamectl set-hostname vps4
echo 127.0.0.1 vps4 | ssh $vps -l root tee -a /etc/hosts
```

## Install some package

```
ssh $vps -l root aptitude install -y emacs perl apt-file xauth
```

## bash helper

```
remf() { echo $@ | xargs -n1 | xargs -i echo 'declare -f {}; echo {}' | . <(cat); }
```

## Create my account

```
addthy() { adduser --disabled-password --gecos 'Thierry Delamare' thy; }
remf addthy | ssh $vps -l root bash
```

## Add my key

```
copykey() { cp -a /root/.ssh /home/thy; chown -R thy.thy /home/thy; }
remf copykey | ssh $vps -l root bash
```

## Configure sudo and staff

```
confsudo() { echo 'Defaults:thy env_keep += HOME' > /etc/sudoers.d/thy; }
addgroups() { echo sudo staff | xargs -n1 | xargs -i adduser thy {}; }
remf confsudo addgroups | ssh $vps -l root bash
```

## Set a passwd for sudo

```
pwgen 12 1 | xclip
pass insert node/thy@$vps
pass git push
pass -c node/thy@$vps
ssh $vps -l root passwd thy
```

## Get a stronger passwd for root

```
pwgen 16 1 | xclip
pass insert node/root@$vps
pass git push
pass -c node/root@$vps
ssh $vps -l root passwd
```
