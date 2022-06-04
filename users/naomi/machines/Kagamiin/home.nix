# Naomi's home configuration for Kagamiin.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, fake Windows layout, the arc-menu hack, and tap-to-click.
  imports = [
    ../../gnome
    ../../gnome/fake-windows.nix
    ../../gnome/arc-menu-hidpi.nix
    ../../gnome/tap-to-click.nix
  ];

}
