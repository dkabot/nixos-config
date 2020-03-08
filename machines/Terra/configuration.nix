# NixOS system-specific configuration file for Touko.

{ config, ... }:


let
  wip-pinebook-pro = builtins.fetchGit {
    url = "https://github.com/theotherjimmy/wip-pinebook-pro.git";
    rev = "95bd47f1dc8701ac293f4113f732f874bad93d69";
    ref = "suspend";
  };

in

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      ../../config/extlinux.nix # systemd-boot bootloader.
      # Pinebook Pro kernel
      "${wip-pinebook-pro}/pinebook_pro.nix"
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Terra/home.nix
  ];

  # Enable panfrost video driver.
  services.xserver.videoDrivers = [ "panfrost" ];

  # Set the hostname.
  networking.hostName = "Terra";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "20.03";

}
