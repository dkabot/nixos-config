# NixOS system-specific configuration file for Mimi.

{ config, pkgs, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      ../../config/systemd-boot.nix # systemd-boot bootloader.
      # Apply HiDPI console.
      ../../config/hidpi-console.nix
      # Apply Surface kernel.
      ../../config/surface-kernel.nix
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; displayManager = "gdm";  username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Mimi/home.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  virtualisation.docker.enable = true;
  users.users.naomi.extraGroups = [ "docker" ];

  # Enable Surface firmware.
  hardware.firmware = with pkgs; [
    surface-firmware
  ];

  # LUKS configuration.
  boot.initrd.luks.devices = {
    Mimi-crypt = {
      device = "/dev/disk/by-uuid/8f8dfe77-fc6a-4283-a4e9-1bef81c98b19";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Set the hostname.
  networking.hostName = "Mimi";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "19.09";

}
