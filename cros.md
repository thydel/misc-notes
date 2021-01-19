# 2021-01-19

- [Using LXD on your Chromebook][]
- [Everything You Need to Know about the Cloud and Cloud Computing, Part I][]
- [Everything You Need to Know about Linux Containers, Part II: Working with Linux Containers (LXC)][]
- [How to Manage Crostini VM Images][]
- [Containers and VM support on Chrome OS][]

[Using LXD on your Chromebook]:
	https://ubuntu.com/blog/using-lxd-on-your-chromebook
	"ubuntu.com"

[Everything You Need to Know about the Cloud and Cloud Computing, Part I]:
	https://www.linuxjournal.com/content/everything-you-need-know-about-cloud-and-cloud-computing-part-i
	"linuxjournal.com"

[Everything You Need to Know about Linux Containers, Part II: Working with Linux Containers (LXC)]:
	https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-ii-working-linux-containers-lxc
	"linuxjournal.com"

[How to Manage Crostini VM Images]:
	https://gist.github.com/iandstanley/c4b1d8bdfb5056f583a7d8ce2891ab45
	"gist.github.com"

[Containers and VM support on Chrome OS]:
	https://www.reddit.com/r/Crostini/wiki/howto/backup
	"reddit.com"

# 2021-01-18

## Adds extra storage to penguin

Follow [How can I run VMs with data images on external storage?][]

In `crosh`

On `lenovo-100e`

```
dev=usbkey
size=64G
```

Allocate a data image on the inserted USB stick.

```bash
vmc create-extra-disk --size=$size "/media/removable/$dev/extra-disk.img"
```

Start termina VM with the disk image mounted.

```bash
vmc start termina --untrusted --extra-disk "/media/removable/$dev/extra-disk.img"
```

In `termina`

```bash
$ lxc config device add penguin data disk source=/mnt/external/0 path=/mnt/data
```

In `penguin`

```console
thy@penguin:~$ df -h /mnt/data
Filesystem      Size  Used Avail Use% Mounted on
/dev/vdd         64G   12G   51G  19% /mnt/data
```

## Adds extra storage to LXC

in `termina`

```bash
lxc storage list
lxc storage create extra dir source=/mnt/external/0/extra
lxc launch images:debian/buster -s extra
lxc exec buster -- bash
```

[How can I run VMs with data images on external storage?]:
	https://chromium.googlesource.com/chromiumos/docs/+/80d0f9e393535248279a8135b48f6a3468586a4a/containers_and_vms.md#how-can-i-run-vms-with-data-images-on-external-storage
	"chromium.googlesource.com"

# 2019-11-27

- [How to find a Chromebook's end of life date?][]
- [Auto Update policy][]

[How to find a Chromebook's end of life date?]:
	https://www.reddit.com/r/chromeos/comments/8558zu/how_to_find_a_chromebooks_end_of_life_date/ "reddit.com"

[Auto Update policy]: https://support.google.com/chrome/a/answer/6220366?hl=en "support.google.com"

# 2019-11-26

## Disable the trackpad

See [Using a mouse? Here’s how to disable the trackpad on your Chromebook][]

- Go to [ash-debug-shortcuts][] in your browser and enable this setting if it’s not already enabled.
- Restart your browser when prompted.
- Use the keyboard combination of Search + Shift + P to diable (or reenable) the trackpad.

[Using a mouse? Here’s how to disable the trackpad on your Chromebook]:
	https://www.aboutchromebooks.com/news/how-to-disable-trackpad-on-a-chromebook/ "aboutchromebooks.com"
[ash-debug-shortcuts]: chrome://flags/#ash-debug-shortcuts "chrome://flags"

## Crostini Wiki Index Page on reddit

See [Crostini Wiki Index Page][]

[Crostini Wiki Index Page]: https://www.reddit.com/r/Crostini/wiki/index "reddit.com"
