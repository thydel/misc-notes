# Migrate from an old account to a new one

- I want to keep same login
- I want to avoid starting from real scratch
- I Want to to tune new account without messing current one
- So I will try to use a pivot account

# Create new user

```
sudo adduser tde
sudo adduser tde staff
sudo cp /etc/sudoers.d/{thy,tde}
echo -e 'g/thy/s//tde/g\nwq' | sudo ed /etc/sudoers.d/tde
```

# Login as new user

From now on

# Copy home stuff

```
old=~thy/data/tde-ws-2019-12-10/root/home/thy
sudo rsync -aHSv $old/usr ~/
sudo rsync -aHSv $old/.ssh ~/
sudo rsync -aHSv $old/.thy ~/
sudo chown -R tde.tde usr .ssh .thy
mv ~/.ssh/known_hosts ~/.ssh/known_hosts.thy
mv .thy .tde
```

# Copy local stuff

```
old=~thy/data/tde-ws-2019-12-10/root
echo sudo rsync -aHSv $old/usr/local/ /usr/local
```

Don't do it, try a fresh restart

# bashrc

```
echo "if [ -f ~/.$USER/bashrc ]; then . ~/.$USER/bashrc; fi" | tee -a ~/.bashrc
ln -s ~/usr/perso-log.d/bash_history .bash_history.d
mkdir -p .bash_history.d/$(hostname -s)
```

# emacs minimal setup

```
f () {
	echo '(defvar base-user (or (getenv "SUDO_USER")(getenv "USER")))'
	echo '(defvar local-dir (concat "~/." base-user "/elisp"))'
	echo '(setq load-path (append (list "." local-dir) load-path ))'
	echo '(load (concat "~/." base-user "/dotemacs.el"))'
}
f | tee -a ~/.emacs

f () {
	echo "(progn (require 'package)" \
	     "(add-to-list 'package-archives '(\"melpa\" . \"http://melpa.org/packages/\") t)" \
         "(package-initialize)" \
	     "(package-install 'default-text-scale))"
}
emacs -q --eval "$(f)"
```

# Uses emacs `package-activated-list` from an already configured workstation

```
list () { emacsclient -s $1 --eval package-activated-list | tr -d '()' | tr ' ' '\n' | sort -u; }
use () { xargs -i echo emacsclient -s $1 --eval \"\(package-install \'{}\)\"; }
run () { declare -f $1; echo $@; }

run list thy | ssh tde-ws -l thy env TMPDIR=$TMPDIR bash | use thy | dash
```

# Bootstrap local stuff

```
(cd ~/usr/thydel.d/helpers; ./helper.mk install)
make -C ~/usr/thydel.d/ansible-cfg install
use-ansible help
(cd /usr/local/ext && test -d ansible-stable-2.9 || git clone --branch stable-2.9 --recursive git://github.com/ansible/ansible.git ansible-stable-2.9)
(cd ~/usr/thydel.d/helpers; . <(use-ansible); helper git-config) # git global conf, once from any git repos
```
