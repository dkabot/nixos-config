# GNOME desktop configuration.

{ config, pkgs, ... }:

{
  # Import common desktop config.
  imports = [
    ./desktop.nix
  ];

  # Enable GNOME desktop environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.dbus.packages = with pkgs; [ gnome3.dconf ];
  # Exclude Totem, so Celluloid can be used instead.
  environment.gnome3.excludePackages = [ pkgs.gnome3.totem ];

  # Add Celluloid.
  environment.systemPackages = with pkgs; [
    celluloid
  ];

}
