<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Got a new old desktop](#got-a-new-old-desktop)
    - [Makes an installable USB key](#makes-an-installable-usb-key)
    - [Default install as usual](#default-install-as-usual)
    - [Adds my keys](#adds-my-keys)
    - [configure `sudo`](#configure-sudo)
    - [Adds and use `x2x`](#adds-and-use-x2x)
    - [Uses emacs packages](#uses-emacs-packages)

<!-- markdown-toc end -->

# Got a new old desktop

## Makes an installable USB key

```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.8.0-amd64-netinst.iso
cp debian-8.8.0-amd64-netinst.iso /dev/sd$usbkeyid
```

## Default install as usual

- Language US english
- Location Paris
- Keyboard US english
- Use whole disk
  - root, var, tmp, home part
  - Use LVM
- Install Gnome, Mate, sshd

## Adds my keys

```bash
ssh-copy-id -o PreferredAuthentications=password tde-lt2
```

## configure `sudo`

`ssh tde-lt2`

```bash
su
adduser thy sudo
```

## Adds and use `x2x`

```bash
ssh tde-lt2 -t sudo aptitude install x2x
ssh -XC tde-lt2 x2x -east -to :0
```

## Uses emacs packages

See [el-get](https://github.com/dimitri/el-get)

```lisp
(el-get-bundle elpa:markdown)
(el-get-bundle elpa:markdown-toc)
```

Or maybe just uses

```lisp
(package-install 'markdown-mode)
(package-install 'markdown-toc)
(package-install 'gh-md)
```

## Get private stuff

```bash
(
	mkdir -p ~/usr/perso.d;
	cd ~/usr/perso.d;
	git clone $perso:usr/perso.d/bash_history.git
)
```
