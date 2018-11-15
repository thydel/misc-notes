# Use LXC on stretch

[LXC]: https://wiki.debian.org/LXC "wiki.debian.org"

Following [LXC][] from `wiki.debian.org`

Install needed packages

```
sudo apt install lxc libvirt-daemon-system libvirt-clients
```

Configure network for independent masqueraded bridge

```
echo 'USE_LXC_BRIDGE="true"' | sudo tee /etc/default/lxc-net

sudo mv /etc/lxc/default.conf /etc/lxc/default.conf.00
echo 'lxc.network.type = veth'                | sudo tee    /etc/lxc/default.conf
echo 'lxc.network.link = lxcbr0'              | sudo tee -a /etc/lxc/default.conf
echo 'lxc.network.flags = up'                 | sudo tee -a /etc/lxc/default.conf
echo 'lxc.network.hwaddr = 00:16:3e:xx:xx:xx' | sudo tee -a /etc/lxc/default.conf

sudo service lxc-net restart
```

Local need for storage space

```
sudo mkdir -p /data/self/var/cache/lxc
sudo mkdir -p /data/self/var/lib/lxc
echo '/data/self/var/cache/lxc  /var/cache/lxc none bind' | sudo tee -a /etc/fstab
echo '/data/self/var/lib/lxc    /var/lib/lxc   none bind' | sudo tee -a /etc/fstab
sudo mount /var/cache/lxc
sudo mount /var/lib/lxc
```

Local need for shorewall

```
echo -e 'lxc\tlxcbr0\t\trouteback,bridge,tcpflags,nosmurfs,routefilter,logmartians' | sudo tee -a /etc/shorewall/interfaces
echo -e 'lxc\tipv4'                                                                 | sudo tee -a /etc/shorewall/zones
echo -e '/POLICY MUST BE LAST/i\nlxc\t\tall\t\tACCEPT\nall\t\tlxc\t\tACCEPT\n.\nwq' | sudo ed     /etc/shorewall/policy

sudo shorewall restart
sudo service lxc-net restart
```

Create first container

```
sudo lxc-create -n stretch -t debian -- -r stretch
```

Change its root password

```
sudo lxc-start -n stretch
echo root:$(pass lxc/root@stretch) | sudo lxc-attach -n stretch chpasswd
sudo lxc-attach -n stretch
```

And allow root ssh login using password

```
echo 'PermitRootLogin yes' | sudo lxc-attach -n stretch -- tee -a /etc/ssh/sshd_config
sudo lxc-attach -n stretch -- service ssh restart
```

Get allocated IP

```
sudo lxc-attach -n stretch -- hostname -I
```

Or maybe choose a fixed one

```
sudo lxc-stop -n stretch

echo LXC_DHCP_CONFILE=/etc/lxc/dnsmasq.conf     | sudo tee -a /etc/default/lxc-net
echo dhcp-hostsfile=/etc/lxc/dnsmasq-hosts.conf | sudo tee /etc/lxc/dnsmasq.conf
stretch=10.0.3.42
echo stretch,$stretch   | sudo tee /etc/lxc/dnsmasq-hosts.conf
echo "$stretch stretch" | sudo tee -a /etc/hosts

sudo service lxc-net restart
sudo lxc-start -n stretch
```

And add you key to `root`

```
ssh-copy-id root@stretch
```

Create your account

```
ssh stretch -l root apt -y install python sudo
ansible -i stretch, all -u root -m user \
  -a "name=$USER password=$(pass lxc/thy@stretch | mkpasswd -5s) update_password=on_create groups=sudo append=yes" -D
(gitname=thyepi;
 ansible -i stretch, all -u root -m authorized_key -a "user=$USER key=https://github.com/$gitname.keys validate_certs=no" -D)
```

Add a dedicated inventory if needed

```
pass="{{ lookup('passwordstore', 'lxc/' + lookup('env','USER') + '@lxc') }}"
echo -e "all: { children: { g_lxc: { hosts: { stretch: }, vars: { ansible_become_pass: \"$pass\" }}}}" > inventory/lxc.yml
```
