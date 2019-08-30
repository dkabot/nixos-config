# Shared NixOS configuration. All systems should utilize what is within this file.

{ config, pkgs, ... }:

{
  imports = [
    # Apply nixpkgs configuration.
    ../pkgs/nixpkgs.nix
    # Bring in relevant user configuration.
    ../users
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  # Use a tmpfs for /tmp.
  boot.tmpOnTmpfs = true;

  # Enable NTFS support.
  boot.supportedFilesystems = [ "ntfs" ];

  # Set the time zone.
  time.timeZone = "America/New_York";

  # Automatically optimize the Nix store.
  nix.autoOptimiseStore = true;

  # Enable Bluetooth.
  hardware.bluetooth.enable = true; # Implied 'true' with GNOME.

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true; # Implied 'true' with GNOME.
    # Add extra modules for nicer Bluetooth codec support.
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    # Full PulseAudio package is necessary for bluetooth audio support.
    package = pkgs.pulseaudioFull;
  };

  # Enable GNOME desktop environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.dbus.packages = with pkgs; [ gnome3.dconf ];
  # Exclude Totem, so Celluloid can be used instead.
  environment.gnome3.excludePackages = [ pkgs.gnome3.totem ];

  # Remove 'xterm' entry in display manager
  services.xserver.desktopManager.xterm.enable = false;

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true; # Implied 'true' with GNOME.
    clickMethod = "clickfinger";
    naturalScrolling = true;
    tapping = true;
  };

  # Enable touch scrolling in Firefox.
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # Add basic packages for system-wide scope.
  environment.systemPackages = with pkgs; [
    htop git mkpasswd unzip
    celluloid
  ];

  # Additional fonts.
  fonts.fonts = with pkgs; [
    ipafont # Japanese
    twemoji-color-font # Emoji
  ];

}
