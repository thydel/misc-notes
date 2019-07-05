# Install nix on debian9

```
p='/data/self/nix /nix'
sudo mkdir -p $p
sudo chown $USER.$USER $p
echo $p none bind,noauto | sudo tee -a /etc/fstab
sudo sysctl kernel.unprivileged_userns_clone=1
echo kernel.unprivileged_userns_clone=1 | sudo tee -a /etc/sysctl.d/nix.conf
curl https://nixos.org/nix/install | sh
. .nix-profile/etc/profile.d/nix.sh
```
