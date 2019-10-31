# NixOS system-specific configuration file for Kagamiin.

{ config, pkgs, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME desktop.
      # Apply HiDPI console.
      ../../config/hidpi-console.nix
      # Apply qzed kernel.
      ../../config/surface-kernel.nix
      # Log naomi in automatically.
      (import ../../config/gdm-autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Kagamiin/home.nix
  ];

  # Add control package.
  environment.systemPackages = with pkgs; [
    linux-surface-control
  ];

  # Enable Surface firmware.
  hardware.firmware = with pkgs; [
    surface-firmware
  ];

  # LUKS configuration.
  boot.initrd.luks.devices = [
    {
      name = "Kagamiin-crypt";
      device = "/dev/disk/by-uuid/518663b3-5a71-49bb-b2a8-1ba7ed5d2c14";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Set the hostname.
  networking.hostName = "Kagamiin";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "19.09";

}
