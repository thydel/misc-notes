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

## Add and use `x2x`

```bash
ssh tde-lt2 -t sudo aptitude install x2x
ssh -XC tde-lt2 x2x -east -to :0
```
