# NixOS system-specific configuration file for Miluiel.

{ config, pkgs, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/plasma.nix # KDE Plasma Desktop.
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; displayManager = "sddm"; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Miluiel/home.nix
  ];

  # Enable nVidia proprietary drivers.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Monitor arrangement. Positioning options don't seem to want to work, not sure why. Still useful for setting primary monitor.
    services.xserver.xrandrHeads = [
    { output = "DP-4"; primary = true; }
    { output = "DP-1"; #monitorConfig =
      #''
      #  Option "Position" "2560 590"
      #''
    }
  ];

  # Use a more recent kernel than 4.19 to ensure hardware support.
  boot.kernelPackages = pkgs.linuxPackages_5_4;

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
