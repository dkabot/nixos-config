# NixOS system-specific configuration file for Mimi.

{ config, pkgs, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      # Apply HiDPI console.
      ../../config/hidpi-console.nix
      # Apply Surface configs without Jakeday kernel.
      ../../config/surface-kernel.nix
      # Log naomi in automatically.
      (import ../../config/gdm-autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Mimi/home.nix
  ];

  # Enable Surface firmware.
  hardware.firmware = with pkgs; [
    surface-firmware
  ];

  # LUKS configuration.
  boot.initrd.luks.devices = [
    {
      name = "Mimi-crypt";
      device = "/dev/disk/by-uuid/8f8dfe77-fc6a-4283-a4e9-1bef81c98b19";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Set the hostname.
  networking.hostName = "Mimi";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "19.09";

}
