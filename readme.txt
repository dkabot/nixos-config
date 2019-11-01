Installation:

0) Configure disks and mount partitions, per the manual.

0.5) Add git if not present.
`nix-channel --update`
`nix-env -i git`

1) Clone repo to some location, like `/cfg`.
`git clone https://github.com/dkabot/nixos-config.git /mnt/cfg`

1.5) Change ownership to a user (optional).
`chown -R 1000:users /mnt/cfg`

2) Generate password files.
`mkpasswd -m sha-512 > /mnt/cfg/users/root.hashedPassword` # Optional
`mkpasswd -m sha-512 > /mnt/cfg/users/USERNAME/USERNAME.hashedPassword`

3) Symlink machine config.
`mkdir -p /mnt/etc/nixos`
`ln -s /mnt/cfg /cfg`
`ln -s /cfg/machines/HOSTNAME/configuration.nix /mnt/etc/nixos/configuration.nix`

4) Pray.
`nixos-generate-config --root /mnt`
`mv /mnt/etc/nixos/hardware-configuration.nix /mnt/cfg/machines/HOSTNAME/hardware-configuration.nix`
`nixos-install`


Home Manager isn't working? Try the following:

1) Update your version numbers, make sure that home-manager is on a current commit and that your stateVersion is accurate.
`nano /cfg/users/default.nix`
`nano /cfg/machines/HOSTNAME/configuration.nix`

2) Rebuild and upgrade, just to be sure. 
`sudo nixos-rebuild boot --upgrade`

3) Create nix per-user folder if it doesn't exist.
`sudo mkdir /nix/var/nix/profiles/per-user/USERNAME`
`sudo chown USERNAME:root /nix/var/nix/profiles/per-user/USERNAME`

4) Make sure to reboot when doing things like these, even step 3).
