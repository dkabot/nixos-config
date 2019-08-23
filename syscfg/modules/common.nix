# Shared NixOS configuration. All systems should utilize what is within this file.

{ config, pkgs, ... }:

{
  imports = [
    # Apply nixpkgs configuration.
    ../../pkgs/nixpkgs.nix
    # Bring in relevant user configuration.
    ../users
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  # Use a tmpfs for /tmp.
  boot.tmpOnTmpfs = true;

  # Set the time zone.
  time.timeZone = "America/New_York";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true; # Implied 'true' with GNOME.

  # Enable GNOME desktop environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  # Remove 'xterm' entry in display manager
  services.xserver.desktopManager.xterm.enable = false;

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true; # Implied 'true' with GNOME.
    clickMethod = "clickfinger";
    naturalScrolling = true;
    tapping = true;
  };

  # Add basic packages for system-wide scope.
  environment.systemPackages = with pkgs; [
    htop git mkpasswd unzip
  ];

}
