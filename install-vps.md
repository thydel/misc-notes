# Got two new vps

- Looks like OVH uses template with unique host keys set
- Since our ansible tools for this task are not rock solid go manual

With `ssh vps1.dom.tld -l root`, then `ssh vps2.dom.tld -l root`

```bash
cd /etc/ssh
mkdir .hide
mv ssh_host_* .hide
ssh-keygen -A
```

On localhost for `vps1` and `vps2`

```bash
source <(ssh $vps.dom.tld -l root 2>&1 | grep ssh-keygen)
ssh-keyscan $vps.dom.tld >> ~/.ssh/known_hosts
ssh $vps.dom.tld -l root -o StrictHostKeyChecking=yes 2>&1 | grep Offending | cut -d: -f2 | xargs -i sed -ie {}d ~/.ssh/known_hosts
```
