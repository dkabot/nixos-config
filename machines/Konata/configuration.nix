# NixOS system-specific configuration file for Konata.

{ config, pkgs, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      ../../config/systemd-boot.nix # systemd-boot bootloader.
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Konata/home.nix
  ];

  # LUKS configuration.
  boot.initrd.luks.devices = {
    Konata-crypt = {
      device = "/dev/disk/by-uuid/a81a7f6d-14e3-45b0-9227-786cf603edb0";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Set the hostname.
  networking.hostName = "Konata";

  # Enable microcode updates.
  hardware.cpu.intel.updateMicrocode = true;

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "20.09";

}
