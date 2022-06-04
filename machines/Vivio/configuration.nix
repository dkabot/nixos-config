# NixOS system-specific configuration file for Vivio.

{ config, ... }:


let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "0cab18a48de7914ef8cad35dca0bb36868f3e1af";
    ref = "master";
  };

in

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      ../../config/systemd-boot.nix # systemd-boot bootloader.
      # Pinebook Pro specific configuration
      "${nixos-hardware}/pine64/pinebook-pro"
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Vivio/home.nix
  ];

  # This has to be false for Tow-Boot as it stands.
  boot.loader.efi.canTouchEfiVariables  = false;

  # The standard initrd doesn't give a passphrase prompt, while systemd init does.
  boot.initrd.systemd.enable = true;

  # LUKS configuration.
  boot.initrd.luks.devices = {
    Vivio-crypt = {
      device = "/dev/disk/by-uuid/ccd0ac84-a9be-4793-962e-418e1677a972";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Set the hostname.
  networking.hostName = "Vivio";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "22.11";

}
