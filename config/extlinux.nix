# Use the extlinux boot loader.

{ config, ... }:

{
  # NixOS wants to enable GRUB by default, don't let it.
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

}

