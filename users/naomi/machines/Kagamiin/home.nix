# Naomi's home configuration for Kagamiin.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, plus tap-to-click and the arc-menu hack.
  imports = [
    ../../gnome
    ../../gnome/arc-menu-hidpi.nix
    ../../gnome/tap-to-click.nix
  ];

}
