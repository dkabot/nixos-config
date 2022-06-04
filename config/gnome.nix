# GNOME desktop configuration.

{ config, pkgs, ... }:

{
  # Import common desktop config.
  imports = [
    ./desktop.nix
  ];

  # Enable GNOME desktop environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  # Exclude Totem, so Celluloid can be used instead.
  environment.gnome.excludePackages = [ pkgs.gnome.totem pkgs.gnome.epiphany ];

  # Add Celluloid.
  environment.systemPackages = with pkgs; [
    celluloid
  ];

}
