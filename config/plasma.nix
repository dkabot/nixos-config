# KDE Plasma desktop configuration.

{ config, pkgs, ... }:

{
  # Import common desktop config.
  imports = [
    ./desktop.nix
  ];

  # Enable Plasma desktop environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Add additional applications.
  environment.systemPackages = with pkgs; [
    # Basic tools not installed by default.
    vlc notepadqq spectacle
  ];

}
