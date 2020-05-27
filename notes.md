<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [2020-05-26 Uses gh on another node](#2020-05-26-uses-gh-on-another-node)
- [2020-05-15 Fix thunderbird date format](#2020-05-15-fix-thunderbird-date-format)
- [2020-05-07 Set python 3 as default](#2020-05-07-set-python-3-as-default)
- [2020-04-25 Uses gh with two context](#2020-04-25-uses-gh-with-two-context)
- [2020-04-18 Compile git 2.26 on debian 9.11](#2020-04-18-compile-git-226-on-debian-911)
- [2020-04-09 disable ipv6](#2020-04-09-disable-ipv6)
- [2020-02-02 light-locker does not work wake up](#2020-02-02-light-locker-does-not-work-wake-up)
- [2020-02-02 mate icon with two displays](#2020-02-02-mate-icon-with-two-displays)
- [2020-01-02 CROS TERMINFO](#2020-01-02-cros-terminfo)
- [2019-12-20 propagate date](#2019-12-20-propagate-date)
- [2019-12-13 use diceware](#2019-12-13-use-diceware)
- [2019-10-18 status of all git repos](#2019-10-18-status-of-all-git-repos)
- [2019-10-18 collect all my awk script](#2019-10-18-collect-all-my-awk-script)
- [2019-10-16 compile git on debian9.11](#2019-10-16-compile-git-on-debian911)
- [2019-10-04 track all untracked remote](#2019-10-04-track-all-untracked-remote)
- [2019-09-23 install ripgrep](#2019-09-23-install-ripgrep)
- [2019-09-20 sftp for ipwebcam](#2019-09-20-sftp-for-ipwebcam)
- [2019-09-13 use greek letter](#2019-09-13-use-greek-letter)
- [2019-09-03 compile git on stretch](#2019-09-03-compile-git-on-stretch)
- [2018-03-23 use meld to commit only part of changes on a file in Git](#2018-03-23-use-meld-to-commit-only-part-of-changes-on-a-file-in-git)
- [2017-09-13 Multiple application profiles](#2017-09-13-multiple-application-profiles)
    - [chrome](#chrome)
    - [firefox](#firefox)
- [2017-08-02 run a SSH server on Chrome OS](#2017-08-02-run-a-ssh-server-on-chrome-os)
- [2017-08-02 Prevents chromeos to unmount USB key when suspending](#2017-08-02-prevents-chromeos-to-unmount-usb-key-when-suspending)
- [2017-06-25 export chrome passwords](#2017-06-25-export-chrome-passwords)
    - [setting the `Password import and export` flag should be enuf](#setting-the-password-import-and-export-flag-should-be-enuf)
    - [But Chrome 59 no longer displays the password Export button](#but-chrome-59-no-longer-displays-the-password-export-button)
    - [Unless you disable `Enable Material Design settings`](#unless-you-disable-enable-material-design-settings)
- [2017-05-12 new git-md tool](#2017-05-12-new-git-md-tool)
- [2017-05-09 new build-ansible tool](#2017-05-09-new-build-ansible-tool)
- [2017-05-06 Removal of gdmflexiserver breaks user switching](#2017-05-06-removal-of-gdmflexiserver-breaks-user-switching)
- [2017-04-24 import one file from another repos](#2017-04-24-import-one-file-from-another-repos)
- [2017-04-24 merge one git repos into another](#2017-04-24-merge-one-git-repos-into-another)
    - [create an empty bare git repo](#create-an-empty-bare-git-repo)
    - [push the hg repos to the new git repos](#push-the-hg-repos-to-the-new-git-repos)
    - [clone the new git repos](#clone-the-new-git-repos)
    - [make some changes](#make-some-changes)
    - [move the whole tree into a subdirectory](#move-the-whole-tree-into-a-subdirectory)
    - [prefix all commit messages](#prefix-all-commit-messages)
    - [and merge in the receiving git repos](#and-merge-in-the-receiving-git-repos)
- [2017-04-22 merge one git repos into another](#2017-04-22-merge-one-git-repos-into-another)
    - [create an empty bare git repo](#create-an-empty-bare-git-repo-1)
    - [push the hg repos to the new git repos](#push-the-hg-repos-to-the-new-git-repos-1)
    - [clone the new git repos](#clone-the-new-git-repos-1)
    - [make some changes](#make-some-changes-1)
    - [move the whole tree into a subdirectory](#move-the-whole-tree-into-a-subdirectory-1)
    - [optionally upgrade git](#optionally-upgrade-git)
    - [and merge in the receiving git repos](#and-merge-in-the-receiving-git-repos-1)
- [2017-04-14 Uses staff group on debian](#2017-04-14-uses-staff-group-on-debian)
- [2017-04-14 View markdown files offline](#2017-04-14-view-markdown-files-offline)
- [2017-03-15 way to run various stdout ansible callbacks](#2017-03-15-way-to-run-various-stdout-ansible-callbacks)
- [2017-03-03 find which socket ssh-agent is using](#2017-03-03-find-which-socket-ssh-agent-is-using)
- [2017-02-25 upgrading ubuntu from 16.10 to 17.04](#2017-02-25-upgrading-ubuntu-from-1610-to-1704)
- [2017-02-24 upgrading ubuntu from 15.04 to 16.10](#2017-02-24-upgrading-ubuntu-from-1504-to-1610)
    - [tmply fix OpenSSH 7.0 disables ssh-dss keys by default](#tmply-fix-openssh-70-disables-ssh-dss-keys-by-default)
    - [fix network manager bug](#fix-network-manager-bug)
    - [fix missing packages](#fix-missing-packages)
- [2017-02-14 install qemacs on chromeos](#2017-02-14-install-qemacs-on-chromeos)
- [2017-02-14 The new openssh version (7.0+) deprecated DSA keys](#2017-02-14-the-new-openssh-version-70-deprecated-dsa-keys)
- [2016-12-21 lvmetad is running but disabled](#2016-12-21-lvmetad-is-running-but-disabled)
- [2016-12-21 Linux 4.8 infos](#2016-12-21-linux-48-infos)

<!-- markdown-toc end -->

# 2020-05-26 Uses gh on another node

```
release=0.8.0
release=0.9.0
wget https://github.com/cli/cli/releases/download/v${release}/gh_${release}_linux_amd64.deb
sudo gdebi gh_${release}_linux_amd64.deb
(cd ~/.config; rsync -av tdeltd.wato:$(pwd)/gh .)
```

# 2020-05-15 Fix thunderbird date format

[Date display format]:
	http://kb.mozillazine.org/Date_display_format "mozillazine.org"

See [Date display format][]

```
env LC_TIME=en_DK thunderbird
```

# 2020-05-07 Set python 3 as default

[debian-set-python-3-as-default]:
	https://michlstechblog.info/blog/debian-set-python-3-as-default/ "michlstechblog.info"

See [debian-set-python-3-as-default][]

```
update-alternatives --install /usr/bin/python python /usr/bin/python3.5 2
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
```

# 2020-04-25 Uses gh with two context

```
release=0.8.0
wget https://github.com/cli/cli/releases/download/v${release}/gh_${release}_linux_amd64.deb
sudo gdebi gh_${release}_linux_amd64.deb

# init in a thydel repo context
gh config set git_protocol ssh
mv ~/.config/gh/config.yml ~/.config/gh/config.yml.thydel

# init in a thyepi repo context
gh config set git_protocol ssh
mv ~/.config/gh/config.yml ~/.config/gh/config.yml.thyepi
#sed -i /thydel/s//thyepi/ ~/.config/gh/config.yml.thyepi

gh() { ln -sf config.yml.${GITHUB_USER:-thyepi} ~/.config/gh/config.yml; command gh "$@"; }

# in a thyepi repo context
gh issue status

# in a thydel repo context
export GITHUB_USER=thydel
gh repo view
```

# 2020-04-18 Compile git 2.26 on debian 9.11

```
sudo apt-get purge libssl-dev
sudo apt-get install libssl1.0-dev
```

Anecdotal pkg

```
sudo aptitude install docbook2x zlib1g-dev
```

Get it

```
git clone git@github.com:git/git.git
git -C git ls-remote --tags origin 'v2.2[2-9]*'
git -C git checkout -b compile v2.26.1
```

Then as usual

```
make configure
./configure --prefix=/usr/local
make all doc info
sudo make install install-doc install-html install-info
```

# 2020-04-09 disable ipv6

On a debian9

```
echo all default lo eth0 | xargs -n1 | xargs -i echo net.ipv6.conf.{}.disable_ipv6 = 1 | sudo tee -a /etc/sysctl.d/90-disable-ipv6.conf
sudo sysctl -p -f /etc/sysctl.d/90-disable-ipv6.conf
```

# 2020-02-02 light-locker does not work wake up

- See [light-locker does not work wake up #138][]

```
echo -e '/light-locker-command --lock/s//dm-tool switch-to-greeter/\nwq' | ed /usr/bin/xflock4
```

Nope!

```
Not running inside a display manager, XDG_SEAT_PATH not defined
```

And no more locking beside

[light-locker does not work wake up #138]:
	https://github.com/the-cavalry/light-locker/issues/138 "github.com issue"


Undo and forget

# 2020-02-02 mate icon with two displays

- Icons not on primary display

```
git clone https://github.com/WinEunuuchs2Unix/iconic.git WinEunuuchs2Unix/iconic
sudo aptitude install yad
sudo aptitude install wmctrl
sudo aptitude install xdotool
sudo aptitude install gvfs-bin
```

- OK, forget about it.

```console
thy@tdews3:~/usr/extern/WinEunuuchs2Unix/iconic$ ./iconic 1
This tool has been deprecated, use 'gio info' instead.
See 'gio help info' for more info.

Moving Desktop Icons to monitor: 1
./iconic: line 466: ColSize / MonIconColumns : division by 0 (error token is "MonIconColumns ")
```


# 2020-01-02 CROS TERMINFO

After installing chromebrew `xterm-256color` is undefefined

```
echo export TERMINFO=/etc/terminfo >> ~/.bashrc
```


# 2019-12-20 propagate date

[How do I change folder timestamps recursively to the newest file?][]
A long time ago I made a perl script ([propagate-date][]) to do that.

But I still didn't find a ready made satisfying answer.

So here is oneliner that will unconditionally recursively set the date
of all dirs to the date of the most recent item

```
find -depth -type d | xargs -i echo 'ls -t {} | echo touch -r {}/$(head -n1) {}' | dash
```

And a slightly better version

```
touchr() { test "$1" -nt "$2" && echo touch -r "$1" "$2"; }; export -f touchr
propadate-date() { find $1 -depth -type d | xargs -i echo 'ls -t {} | echo touchr {}/$(head -n1) {}' | dash | bash; }
```

- `propadate-date $dir`        will output the needed list of touch cmd
- `propadate-date $dir | dash` will obviously play the generated script


[propagate-date]:
	https://github.com/thydel/propagate-date "github.com repo"

[How do I change folder timestamps recursively to the newest file?]:
	https://unix.stackexchange.com/questions/1524/how-do-i-change-folder-timestamps-recursively-to-the-newest-file "stackexchange.com"

# 2019-12-13 use diceware

See [Password Strength][] and [French word list][]

```
sudo aptitude install diceware
diceware
git clone https://github.com/chmduquesne/diceware-fr
sudo cp diceware-fr/diceware-fr-5-jets.txt /usr/lib/python2.7/dist-packages/diceware/wordlists/wordlist_fr.txt
diceware -w fr
```

[Password Strength]: https://xkcd.com/936/ "xkcd.com"
[French word list]: https://github.com/chmduquesne/diceware-fr "github.com"

# 2019-10-18 status of all git repos

```
all-git () { locate -b \\.git | xargs dirname; }
git-cmd () { xargs -i echo echo '\# {};' git -C {} "$@" | dash; }
all-git | git-cmd status -s | factor-prefix.awk -v squeeze=1 -v filter="#"
```

Use [factor-prefix.awk][] to show only unclean repos

[factor-prefix.awk]: https://github.com/thydel/misc-script/blob/master/factor-prefix.awk "github.com file"


# 2019-10-18 collect all my awk script

```
uniq-basename () { locate .awk | grep thy | xargs basename -a | sort -u; }
uniq-files () { xargs -i locate {} | grep -v -e .hg -e .svn -e \~  | xargs md5sum | sort | uniq -w32 | cut -c 35-; }
collect () { mkdir -p ~/tmp/awk; xargs cp --backup=t -pft tmp/awk; }
uniq-basename | uniq-files | collect
```

# 2019-10-16 compile git on debian9.11

See [Error on "make" #303][]

```
sudo apt-get purge libssl-dev
sudo apt-get install libssl1.0-dev
```

Anecdotal pkg

```
sudo aptitude install docbook2x
```

Get it

```
git clone git@github.com:git/git.git
git -C git ls-remote --tags origin 'v2.2[2-4]*'
git -C git checkout -b compile v2.23.0
```

Then as usual

```
make configure
./configure --prefix=/usr/local
make all doc info
sudo make install install-doc install-html install-info
```

[Error on "make" #303]: https://github.com/rauc/rauc/issues/303 "github.com issue"

# 2019-10-04 track all untracked remote

```
gitrem () { git for-each-ref --format='%(refname)' refs/remotes/origin | grep -v /HEAD | cut -d/ -f4; }
gitloc () { git for-each-ref --format='%(refname)' refs/heads/ | cut -d/ -f3; }
gittab () { comm -23 <(gitrem) <(gitloc) | xargs -ri echo git branch -t {} origin/{}; }
```

For gitconfig alias

```
[alias]
	lrb = !git for-each-ref --format='%(refname)' refs/remotes/origin | grep -v /HEAD | cut -d/ -f4
	llb = !git for-each-ref --format='%(refname)' refs/heads/ | cut -d/ -f3
	tab = !bash -c 'comm -23 <(git lrb) <(git llb) | xargs -ri echo git branch -t {} origin/{}'
```

# 2019-09-23 install ripgrep

```
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
install ripgrep_11.0.1_amd64.deb /usr/local/dist
sudo dpkg -i /usr/local/dist/ripgrep_11.0.1_amd64.deb
dpkg -L ripgrep
```

# 2019-09-20 sftp for ipwebcam

Better way

```
adduser  --gecos 'ipwebcam for sftp' ipwebcam --shell /usr/bin/mysecureshell
echo "Match User=ipwebcam
  PasswordAuthentication yes
  AllowGroups ipwebcam
  PasswordAuthentication no
  AllowTCPForwarding no
  X11Forwarding no" >> /etc/ssh/sshd_config

service ssh restart

install -o ipwebcam -g ipwebcam -m 700 -d ~ipwebcam/.ssh
install -o ipwebcam -g ipwebcam -m 600 ~/.ssh/authorized_keys ~ipwebcam/.ssh
```

Firts try

```
groupadd -r sftp_users
adduser --home /home/sftp/ipwebcam --gecos 'ipwebcam for sftp' ipwebcam
usermod -G sftp_users ipwebcam

echo "AllowGroups sftp_users
Match user ipwebcam
  PasswordAuthentication yes
  ChrootDirectory /home/sftp
  ForceCommand internal-sftp
  AllowTCPForwarding no
  X11Forwarding no" >> /etc/ssh/sshd_config

service ssh restart

install -o ipwebcam -g ipwebcam -m 700 -d ~ipwebcam/.ssh
install -o ipwebcam -g ipwebcam -m 600 ~/.ssh/authorized_keys ~ipwebcam/.ssh
```

# 2019-09-13 use greek letter

```
xmodmap -pke | grep dead_greek | ifne -n xmodmap -pk | grep Control_R | awk '{print $1}' | xargs -i echo xmodmap -e '"keycode {} = dead_greek dead_greek dead_greek dead_greek"'
setxkbmap # undo
```

# 2019-09-03 compile git on stretch

```
aptitude install make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip asciidoc docbook2x
git clone git@github.com:git/git.git
git -C git checkout -b compile-v2.23.0 v2.23.0
make -C git prefix=/usr/local all doc info
sudo make -C git prefix=/usr/local install install-doc install-html install-info
sudo chmod g+w /usr/local/bin # because git install break debian staff setup
hash -r # forget /usr/bin/git (git version 2.11.0)
git --version # git version 2.23.0
```

# 2018-03-23 use meld to commit only part of changes on a file in Git

Found [Commit only part of a file in Git][]

```
sudo aptitude install meld
git stash
git difftool -d -t meld stash
# left window is the copy of the stash version
# rigth window is the working dir version
# apply whatever selected changes from the left to the rigth, save and quit
git commit -a -m 'for the selected changes'
git stash pop
```
See also [View differences of branches with meld?][]

[Commit only part of a file in Git]:
	https://stackoverflow.com/questions/1085162/commit-only-part-of-a-file-in-git "stackoverflow.com"

[View differences of branches with meld?]:
	https://stackoverflow.com/questions/2006032/view-differences-of-branches-with-meld/2006241 "stackoverflow.com"

# 2017-09-13 Multiple application profiles

## chrome

`.config/mate/panel2.d/default/launchers/google-chrome.desktop`

```
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=/usr/local/share/icons/Google_Chrome_icon_(2011).svg
Exec=google-chrome-beta --profile-directory=Default
Icon=mate-panel-launcher
Name[en_US]=Perso
Name=Perso
```

`.config/mate/panel2.d/default/launchers/google-chrome-1.desktop`

```
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=/usr/local/share/icons/Chrome_Logo.svg
Exec=google-chrome-beta --profile-directory='Profile 1'
Icon=mate-panel-launcher
Name[en_US]=Epiconcept
Name=Epiconcept
```

## firefox

Add new profile

```
firefox-esr -P
```

`.config/mate/panel2.d/default/launchers/firefox-esr.desktop`

```
#!/usr/bin/env xdg-open

[Desktop Entry]
Name=Firefox ESR
Name[fr]=Firefox ESR
Comment=Browse the World Wide Web
Comment[fr]=Navigue sur Internet
GenericName=Web Browser
GenericName[fr]=Navigateur Web
X-GNOME-FullName=Firefox ESR Web Browser
X-GNOME-FullName[fr]=Navigateur Web Firefox ESR
Exec=/usr/lib/firefox-esr/firefox-esr -P Epiconcept %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=firefox-esr
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupWMClass=Firefox-esr
Icon[en_US]=/usr/local/share/icons/Firefox_icon.svg
Name[en_US]=Firefox ESR EpiConcept
```

`.config/mate/panel2.d/default/launchers/firefox-esr-1.desktop`

```
#!/usr/bin/env xdg-open

[Desktop Entry]
Name=Firefox ESR
Name[fr]=Firefox ESR
Comment=Browse the World Wide Web
Comment[fr]=Navigue sur Internet
GenericName=Web Browser
GenericName[fr]=Navigateur Web
X-GNOME-FullName=Firefox ESR Web Browser
X-GNOME-FullName[fr]=Navigateur Web Firefox ESR
Exec=/usr/lib/firefox-esr/firefox-esr -P default %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=firefox-esr
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupWMClass=Firefox-esr
Name[en_US]=Firefox ESR Perso
```

# 2017-08-02 run a SSH server on Chrome OS

[Chromebook: run a SSH server on Chrome OS]: https://www.dereckson.be/blog/2015/01/15/chromebook-run-a-ssh-server-on-chrome-os/

# 2017-08-02 Prevents chromeos to unmount USB key when suspending

So as to allow using Crouton on an USB key.

[USB stick keeps being remounted by Chrome OS?][] tells to use `/sys/bus/usb/devices/power/persist`
and [Linux: How to map a blockdevice to a USB-device?][] give a usable heuristic

```console
dev=$(ls -l /sys/bus/usb/devices/*/driver | grep storage | cut -d/ -f6 | cut -d: -f1)
echo 1 | sudo tee /sys/bus/usb/devices/$dev/power/persist
```

[USB stick keeps being remounted by Chrome OS?]: https://github.com/dnschneid/crouton/issues/1936 "github.com"
[Linux: How to map a blockdevice to a USB-device?]:
	https://stackoverflow.com/questions/3493858/linux-how-to-map-a-blockdevice-to-a-usb-device "stackoverflow.com"

# 2017-06-25 export chrome passwords

## setting the `Password import and export` flag should be enuf

Set `chrome://flags/#password-import-export` to `enabled`

## But Chrome 59 no longer displays the password Export button

See [Chrome 59 no longer displays the password Export button](https://productforums.google.com/forum/#!topic/chrome/99KZmH2DRrA)

## Unless you disable `Enable Material Design settings`

Unset `chrome://flags/#enable-md-settings`

# 2017-05-12 new git-md tool

Use it to add TOC to any markdown file named `*-notoc.md`

```bash
git-md notes.md
```
Creates `notes.md` from `notes-notoc.md`

# 2017-05-09 new build-ansible tool

I used to run `ansible` from source (See [use-ansible.mk](https://github.com/thydel/helpers/blob/master/use-ansible.mk))

Once
```bash
(cd ~/usr/ext; git clone --branch stable-2.3 --recursive git://github.com/ansible/ansible.git ansible-stable-2.3)
```

Then
```bash
(cd ~/usr/ext/ansible-stable-2.3; git pull --rebase; git submodule update --init --recursive)
```

And
```bash
source ~/usr/ext/ansible-stable-2.3/hacking/env-setup -q
```

Then come the need to easily use `ansible` modules or even simple
generic playbooks it helps to have a system wide installed `ansible`.

[Cannot build Ubuntu deb package from git sources]: https://github.com/ansible/ansible/issues/22733

But `make deb` don't work out of the box (See
[Cannot build Ubuntu deb package from git sources][]))

New tool to make ansible deb (See [build-ansible.mk](https://github.com/thydel/helpers/blob/master/build-ansible.mk))

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

# 2017-04-24 import one file from another repos

[format-patch for a single file]:
	http://stackoverflow.com/questions/7885075/format-patch-for-a-single-file "stackoverflow"
	
See [format-patch for a single file][]

```bash
git -C $repos format-patch --stdout --root $file | git am -3
```

Or

```bash
git -C $repos format-patch --stdout --root $file | git am -3 --committer-date-is-author-date
```

But I can't tell if that's a safe option.

# 2017-04-24 merge one git repos into another

[Advanced Git branch filtering]:
	https://devsector.wordpress.com/2014/10/05/advanced-git-branch-filtering/ "wordpress"

More advice from [Advanced Git branch filtering][]

[Our helpers]:
	https://github.com/thydel/helpers "github.com/thydel"

And more tools from [Our helpers][]

## create an empty bare git repo

`$name` is a hg repos already configured for [the Hg-Git mercurial plugin][]

```bash
git init --bare $name-git.git
```

## push the hg repos to the new git repos

```bash
pwd=$(pwd);
hg --cwd $name --config git=$pwd/$name-git.git push git
```

## clone the new git repos

```bash
git clone $name-git.git
```

## make some changes

e.g. `git mv .hgignore .gitignore` and edit `.gitignore`

## move the whole tree into a subdirectory

See `helper git-index-filter`

From the git repo to be merged

```bash
git-move-whole-tree-in-subdir $subdir show=1
git-move-whole-tree-in-subdir $subdir
```

Then possibly

```bash
git-rename-top-subdir $newname renamed=$oldname show=1
git-rename-top-subdir $newname renamed=$oldname
```

## prefix all commit messages

See `helper git`

From the git repo to be merged

```bash
git filter-branch --msg-filter 'echo -n "$prefix " && cat'
```

Then possibly

```bash
git filter-branch --msg-filter 'sed "s/$from/$to/"'
```

## and merge in the receiving git repos

From the receiving git repos

```bash
git remote add $newname $pwd/$name-git
git fetch $newname master
git merge --allow-unrelated-histories --no-edit $newname/master
git remote delete $newname
git push
```

# 2017-04-22 merge one git repos into another

[Combining Git Repositories]:
	http://ericlathrop.com/2014/01/combining-git-repositories/ "ericlathrop.com"
[Combining multiple git repositories]:
	http://stackoverflow.com/questions/277029/combining-multiple-git-repositories/618113 "stackoverflow"
[Moving a directory in git from one repo to another]:
	http://halfhourhacks.blogspot.fr/2016/07/moving-directory-in-git-from-one-repo.html "blogspot"

[git-filter-branch - Rewrite branches]:
	https://git-scm.com/docs/git-filter-branch "git-scm.com"

See [Combining Git Repositories][],
[Combining multiple git repositories][],
[Moving a directory in git from one repo to another][] and many
others; all refering to
[git-filter-branch][git-filter-branch - Rewrite branches] man(1)
(search "To move the whole tree into a subdirectory, or remove it from
there")

[the Hg-Git mercurial plugin]: http://hg-git.github.io

As we start from a Mercurial repos, we first need to export it via
[the Hg-Git mercurial plugin][]

## create an empty bare git repo

`$name` is a hg repos already configured for [the Hg-Git mercurial plugin][]

```bash
git init --bare $name-git.git
```

## push the hg repos to the new git repos

```bash
pwd=$(pwd);
hg --cwd $name --config git=$pwd/$name-git.git push git
```

## clone the new git repos

```bash
git clone $name-git.git
```

## make some changes

e.g. `git mv .hgignore .gitignore` and edit `.gitignore`

## move the whole tree into a subdirectory

```bash
git filter-branch --index-filter \
        'git ls-files -s | sed "s-\t\"*;&$name/;" |
                GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
         mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD
```

## optionally upgrade git

On `jessie` git don't have `--allow-unrelated-histories`

```bash
aptitude -t jessie-backports install git
```

## and merge in the receiving git repos

From the receiving git repos

```bash
git remote add $name $pwd/$name-git
git fetch $name master
git merge --allow-unrelated-histories --no-edit $name/master
git remote delete $name
git push
```

# 2017-04-14 Uses staff group on debian

[Debian wiki on SystemGroups]: https://wiki.debian.org/SystemGroups

Following [Debian wiki on SystemGroups][]

	staff: Allows users to add local modifications to the system
	(/usr/local) without needing root privileges (note that
	executables in /usr/local/bin are in the PATH variable of any
	user, and they may "override" the executables in /bin and /usr/bin
	with the same name). Compare with group "adm", which is more
	related to monitoring/security.

```bash
adduser $USER staff
exec bash -i
```

Then (in this case to use latest `pyvmomi` for `ansible` latest `vmware` *modules*)

```bash
sudo aptitude purge python-pyvmomi python-pyvmomi-doc
pip install --upgrade pyvmomi
```

# 2017-04-14 View markdown files offline

[View markdown files offline]:
	http://stackoverflow.com/questions/9843609/view-markdown-files-offline "stackoverflow"

See [View markdown files offline][]

```bash
pip install grip
grip -b # for README
>>>>>>> fd2eec9cb4ce77a38605dbfeda792598970befb5
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
