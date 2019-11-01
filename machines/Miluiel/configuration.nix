# NixOS system-specific configuration file for Miluiel.

{ config, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      # Log naomi in automatically.
      (import ../../config/gdm-autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Miluiel/home.nix
  ];

  # Enable nVidia proprietary drivers.
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.displayManager.gdm.wayland = false;

  # LUKS configuration.
  boot.initrd.luks.devices = [
    {
      name = "Miluiel-crypt";
      device = "/dev/disk/by-uuid/4a8e9b56-23cc-4fa8-8021-1f6d3c39777d";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Set the hostname.
  networking.hostName = "Miluiel";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "20.03";

}
