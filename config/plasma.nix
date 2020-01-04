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

  # Enable NetworkManager (not automatic for Plasma).
  networking.networkmanager.enable = true;

  # Add additional applications.
  environment.systemPackages = with pkgs; [
    # System software not installed by default.
    plasma-browser-integration
    # Basic tools not installed by default.
    vlc notepadqq spectacle okular gwenview ark
  ];

}
