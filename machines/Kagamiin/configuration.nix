# NixOS system-specific configuration file for Kagamiin.

{ config, pkgs, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "0cb5491af9da8d6f16540ffc4db24e2361852e46";
    #ref = "master";
  };

in

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME desktop.
      ../../config/systemd-boot.nix # systemd-boot bootloader.
      # Apply Surface kernel.
      "${nixos-hardware}/microsoft/surface"
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Kagamiin/home.nix
  ];

  # Add control package.
  environment.systemPackages = with pkgs; [
    surface-control
  ];

  # Enable GPU switching.
  #hardware.bumblebee = {
  #  enable = true;
  #  pmMethod = "none"; # Using surface-control to control power; leaving this on "auto" installs bbswitch, which we don't need.
  #};

  # LUKS configuration.
  boot.initrd.luks.devices = {
    Kagamiin-crypt = {
      device = "/dev/disk/by-uuid/cb62ae0a-2c43-4256-9bca-8cc8f40d40cd";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Set the hostname.
  networking.hostName = "Kagamiin";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "21.03";

}
