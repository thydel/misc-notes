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
