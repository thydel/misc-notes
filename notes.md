# 2017-05-06 Removal of gdmflexiserver breaks user switching

```
** (gdmflexiserver:11356): WARNING **: Unable to create transient display: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.gnome.DisplayManager was not provided by any .service files GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.gnome.DisplayManager was not provided by any .service files
```

[Removal of gdmflexiserver breaks user switching]: https://bugs.launchpad.net/ubuntu/+source/xfswitch-plugin/+bug/1320560

See [Removal of gdmflexiserver breaks user switching][]

A simple workaround is creating the file /usr/local/bin/gdmflexiserver:

```bash
#!/bin/sh
#
# replacement for missing gdmflexiserver in Ubuntu 14.04
#
dm-tool switch-to-greeter
```

# 2017-03-15 way to run various stdout ansible callbacks

```bash
env ANSIBLE_STDOUT_CALLBACK=debug     playbook.yml
env ANSIBLE_STDOUT_CALLBACK=default   playbook.yml
env ANSIBLE_STDOUT_CALLBACK=dense     playbook.yml
env ANSIBLE_STDOUT_CALLBACK=json      playbook.yml
env ANSIBLE_STDOUT_CALLBACK=minimal   playbook.yml
env ANSIBLE_STDOUT_CALLBACK=oneline   playbook.yml
env ANSIBLE_STDOUT_CALLBACK=selective playbook.yml
```

# 2017-03-03 find which socket ssh-agent is using

For `ssh-agent`

```bash
export SSH_AUTH_SOCK=/$(sudo lsof -a -U -u $USER -c ssh-agent -Fn -w | tail -1 | cut -d/ -f2-)
```

For `gnome-keyring`

```bash
export SSH_AUTH_SOCK=/$(sudo lsof -a -U -u $USER -c gnome-keyring -Fn -w | grep ssh | cut -d/ -f2-)
```

# 2017-02-25 upgrading ubuntu from 16.10 to 17.04

```
*ERROR*: Font `DejaVu Sans Mono:pixelsize=14:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true' is not defined
```

Workaround [here][Can't change font]

[Can't change font]: http://emacs.stackexchange.com/questions/24048/cant-change-font "emacs.stackexchange.com"

```lisp
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))
```

Stupid me. Wrong diagnostic. Always try `emacs -q` first. The error
was caused by an old forgotten kludge in `.emacs`.

While no looking for it, found how to fix `emacsclient` setup

```lisp
(add-hook 'window-setup-hook (lambda () (tool-bar-mode -1)(scroll-bar-mode -1)))
```

# 2017-02-24 upgrading ubuntu from 15.04 to 16.10

## tmply fix OpenSSH 7.0 disables ssh-dss keys by default

```bash
echo 'PubkeyAcceptedKeyTypes = +ssh-dss' >> ~/.ssh/config
```

## fix network manager bug

```bash
touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
service network-manager restart
```

## fix missing packages

```bash
aptitude install topmenu-gtk2
aptitude install topmenu-gtk3
```

# 2017-02-14 install qemacs on chromeos

[Dev-Install: Installing Developer and Test packages onto a Chrome OS device](https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/install-software-on-base-images "www.chromium.org")


# 2017-02-14 The new openssh version (7.0+) deprecated DSA keys

While adding my DSA keys to my new chromeos laptop.
Found [workaround here][SSH keeps skipping my pubkey and asking for a password].

```bash
echo 'PubkeyAcceptedKeyTypes +ssh-dss' >> ~/.ssh/config
```

[SSH keeps skipping my pubkey and asking for a password]: http://unix.stackexchange.com/questions/247612/ssh-keeps-skipping-my-pubkey-and-asking-for-a-password "unix.stackexchange.com"

# 2016-12-21 lvmetad is running but disabled

While upgrading on `jessie` nodes using `jessie-backports`

	WARNING: lvmetad is running but disabled. Restart lvmetad before enabling it!

- [kernel update - WARNING: lvmetad is running but disabled. Restart lvmetad before enabling it!][161221-1]
- [What is lvmetad and why would I want or need to use it?][161221-2]
- [lvmetad(8)][lvmetad(8)]

[161221-1]: http://unix.stackexchange.com/questions/293755/kernel-update-warning-lvmetad-is-running-but-disabled-restart-lvmetad-before "unix.stackexchange.com"

[161221-2]: http://unix.stackexchange.com/questions/166832/what-is-lvmetad-and-why-would-i-want-or-need-to-use-it "unix.stackexchange.com"

[lvmetad(8)]: https://linux.die.net/man/8/lvmetad "man"

# 2016-12-21 Linux 4.8 infos

While upgrading on `jessie` nodes using `jessie-backports`, better
take note before possible side effect.

linux-latest (76) unstable; urgency=medium

  * From Linux 4.8, several changes have been made in the kernel
    configuration to 'harden' the system, i.e. to mitigate security bugs.
    Some changes may cause legitimate applications to fail, and can be
    reverted by run-time configuration:
    - On 64-bit PCs (amd64), the old 'virtual syscall' interface is
      disabled.  This breaks (e)glibc 2.13 and earlier.  To re-enable it,
      set the kernel parameter: vsyscall=emulate
    - On most architectures, the /dev/mem device can no longer be used to
      access devices that also have a kernel driver.  This breaks dosemu
      and some old user-space graphics drivers.  To allow this, set the
      kernel parameter: iomem=relaxed
    - The kernel log is no longer readable by unprivileged users.  To
      allow this, set the sysctl: kernel.dmesg_restrict=0

 -- Ben Hutchings <ben@decadent.org.uk>  Sat, 29 Oct 2016 02:05:32 +0100

linux-latest (75) unstable; urgency=medium

  * From Linux 4.7, the iptables connection tracking system will no longer
    automatically load helper modules.  If your firewall configuration
    depends on connection tracking helpers, you should explicitly load the
    required modules.  For more information, see
    <https://home.regit.org/netfilter-en/secure-use-of-helpers/>.

 -- Ben Hutchings <ben@decadent.org.uk>  Sat, 29 Oct 2016 01:53:18 +0100
