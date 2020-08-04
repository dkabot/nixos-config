# NixOS system-specific configuration file for Touko.

{ config, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config/gnome.nix # GNOME Desktop.
      ../../config/systemd-boot.nix # systemd-boot bootloader.
      # Log naomi in automatically.
      (import ../../config/autologin.nix { inherit config; username = "naomi"; })
      # Machine-specific home configuration for naomi.
      ../../users/naomi/machines/Touko/home.nix
  ];

  # Enable TLP.
  services.tlp.enable = true;

  # LUKS configuration.
  boot.initrd.luks.devices = {
    Touko-crypt = {
      device = "/dev/disk/by-uuid/3b274bdb-32d7-401e-88c0-8f79422a8155";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Set the hostname.
  networking.hostName = "Touko";

  # Enable microcode updates.
  hardware.cpu.intel.updateMicrocode = true;

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "20.09";

}
