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
`mkpasswd -m sha-512 > /mnt/cfg/syscfg/users/USERNAME.hashedPassword`

3) Symlink machine config.
`ln -s /mnt/cfg /cfg`
`ln -s /cfg/machines/HOSTNAME/configuration.nix /mnt/etc/nixos/configuration.nix`

4) Pray.
`nixos-generate-config --root /mnt`
`mv /mnt/etc/nixos/hardware-configuration.nix /mnt/cfg/machines/HOSTNAME/hardware-configuration.nix`
`nixos-install`
