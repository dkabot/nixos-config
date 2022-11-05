# NixOS system-specific configuration file for Vivio.

{ config, ... }:


let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "9b98a70d46b109bcc82bbafdd0c918330d791fed";
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

  # Delay automatic login to work around loading in X11 at all times.
  services.xserver.displayManager.gdm.autoLogin.delay = 1;
  # An even hackier way of doing the above, in case the above fails.
  #services.xserver.displayManager.job.preStart = "sleep 5";

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
