Installation:

0) Configure disks and mount partitions, per the manual.

0.5) Add git if not present.
`nix-channel --update`
`nix-env -iA nixos.git`

1) Clone repo to some location, like `/cfg`.
`git clone https://github.com/dkabot/nixos-config.git /mnt/cfg`

2) Generate password files.
`mkpasswd -m sha-512 > /mnt/cfg/users/root.hashedPassword` # Optional
`mkpasswd -m sha-512 > /mnt/cfg/users/USERNAME/USERNAME.hashedPassword`

3) Create  `/etc/nixos` and symlink `/cfg` to `/mnt/cfg` for later.
`mkdir -p /mnt/etc/nixos`
`ln -s /mnt/cfg /cfg`

3.5) Create new machine config, if one doesn't exist.
`nixos-generate-config --root /mnt`
`mv /mnt/etc/nixos/configuration.nix /mnt/cfg/machines/HOSTNAME/configuration.nix`
`mv /mnt/etc/nixos/hardware-configuration.nix /mnt/cfg/machines/HOSTNAME/hardware-configuration.nix`

4) Symlink machine config.
`ln -s /cfg/machines/HOSTNAME/configuration.nix /mnt/etc/nixos/configuration.nix`

5) Change ownership to a user (optional).
`chown -R 1000:users /mnt/cfg`

6) Pray.
`nixos-install`


Home Manager isn't working? Try the following:

1) Create nix per-user folder if it doesn't exist.
`sudo mkdir /nix/var/nix/profiles/per-user/USERNAME`
`sudo chown USERNAME:root /nix/var/nix/profiles/per-user/USERNAME`

2) Rebuild and upgrade, just to be sure. 
`sudo nixos-rebuild boot --upgrade`

3) Reboot.

Still not working? Try updating home-manager and ensure that your stateVersion is accurate.
`nano /cfg/users/default.nix`
`nano /cfg/machines/HOSTNAME/configuration.nix`
