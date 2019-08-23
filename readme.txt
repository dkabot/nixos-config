Installation:

1) Clone repo to some location, like `/cfg`.
`git clone https://github.com/dkabot/nixos-config.git /mnt/cfg`

1.5) Change ownership to a user (optional).
`chown -R 1000:users /mnt/cfg`

2) Generate password files.
`mkpasswd -m sha-512 > /mnt/cfg/syscfg/users/USERNAME.hashedPassword`

3) Symlink machine config.
`ln -s /mnt/cfg/syscfg/machines/HOSTNAME/configuration.nix /mnt/etc/nixos/configuration.nix`

4) Pray.
