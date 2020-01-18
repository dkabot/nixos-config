# NixOS system-specific configuration file for Konata.

{ config, pkgs, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      ../../config/systemd-boot.nix # systemd-boot bootloader.
      # Use GRUB bootloader.
      (import ../../config/grub.nix { inherit config; grubDevice = "/dev/disk/by-id/ata-SanDisk_Ultra_II_960GB_161401805476"; encryptedDisk = false; })
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; displayManager = "gdm"; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Konata/home.nix
  ];

  # Enable nVidia proprietary drivers.
  services.xserver.videoDrivers = [ "nvidia" ];

  # LUKS configuration.
  boot.initrd.luks.devices = {
    Konata-crypt = {
      device = "/dev/disk/by-uuid/9c892847-2acf-4f34-aaa9-aca2e8ce5d9b";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Set the hostname.
  networking.hostName = "Konata";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "20.03";

}
