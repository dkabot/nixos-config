# NixOS system-specific configuration file for Touko.

{ config, ... }:

{
  imports = [
      # Import the results of the hardware scan and apply common configuration.
      ./hardware-configuration.nix
      ../../config
      # Log naomi in automatically.
      (import ../../config/gdm-autologin.nix { inherit config; username = "naomi"; })
  ];

  # Enable TLP.
  services.tlp.enable = true;

  # LUKS configuration.
  boot.initrd.luks.devices = [
    {
      name = "Touko-crypt";
      device = "/dev/disk/by-uuid/c153873e-2497-4537-a875-3ed92aeb4a08";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Set the hostname.
  networking.hostName = "Touko";

  # The danger setting; see 'default-configuration.nix' for details.
  system.stateVersion = "19.09";

}
