# Use autossh to start a reverse ssh tunnel

## Choose params

```
export REVSSH_TAG=revssh1
export REVSSH_HOSTNAME=host.domain.tld
export REVSSH_PORT=22
export REVSSH_USER=$USER
```

## Use port file

```
echo $(hostname -s) $RANDOM >> /etc/local/revssh # not random
```

## Install autossh, generate a dedicated key and install pubkey on rev node

```
sudo aptitude install autossh
sudo mkdir -p /etc/autossh
sudo proot -w /etc/autossh ssh-keygen -f $REVSSH_TAG-key
sudo cat /etc/autossh/$REVSSH_TAG-key.pub | ssh $REVSSH_HOSTNAME -p $REVSSH_PORT -l $REVSSH_USER tee -a .ssh/authorized_keys
```

## Generate autossh invocation

```
# git -C ~/usr/ssh-config pull
# proot -w ~/usr/ssh-config make all
echo '#!/bin/bash' | sudo tee /etc/autossh/$REVSSH_TAG
echo autossh -f $REVSSH_TAG -R $(grep $(hostname -s) /etc/local/revssh | awk '{print $2}'):localhost:22 -N | sudo tee -a /etc/autossh/$REVSSH_TAG
sudo chmod +x /etc/autossh/$REVSSH_TAG
```

## Generate ssh config stanza

```

sudo test -d /root/.ssh || (sudo mkdir /root/.ssh; sudo chmod 700 /root/.ssh)
sudo test -s /root/.ssh/config || echo -e '# -*- Mode: ssh-config; -*-\n' | sudo tee /root/.ssh/config
echo -e "\nHost $REVSSH_TAG\n  Hostname $REVSSH_HOSTNAME" | sudo tee -a /root/.ssh/config
echo -e "  Port $REVSSH_PORT\n  User $REVSSH_USER\n  IdentityFile /etc/autossh/$REVSSH_TAG-key" | sudo tee -a /root/.ssh/config
```

## Launch autossh

```
sudo ssh $REVSSH_TAG id
pgrep -f "autossh +$REVSSH_TAG" || sudo /etc/autossh/$REVSSH_TAG
pgrep -f "autossh +$REVSSH_TAG" | xargs -r ps
pkill -3 -f "autossh +$REVSSH_TAG"
```

# Use autossh to start a socks forward

## Choose params

```
export SOCSSH_TAG=socssh1
export SOCSSH_HOSTNAME=host.domain.tld
```

## Use port file

```
echo $SOCSSH_HOSTNAME $RANDOM >> /usr/local/etc/socssh # not random
```

## Generate autossh invocation

```
mkdir -p /usr/local/etc/autossh
echo '#!/bin/bash' | tee /usr/local/etc/autossh/$SOCSSH_TAG
echo autossh -f $SOCSSH_HOSTNAME -D$(grep $SOCSSH_HOSTNAME /usr/local/etc/socssh | awk '{print $2}') -Nn >> /usr/local/etc/autossh/$SOCSSH_TAG
chmod +x /usr/local/etc/autossh/$SOCSSH_TAG
```

## Launch autossh

```
ssh $SOCSSH_HOSTNAME id
pgrep -f "autossh +$SOCSSH_HOSTNAME" || /usr/local/etc/autossh/$SOCSSH_TAG
pgrep -f "autossh +$SOCSSH_HOSTNAME" | xargs -r ps
pkill -3 -f "autossh +$SOCSSH_HOSTNAME"
```
