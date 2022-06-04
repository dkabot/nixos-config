# Naomi's home configuration for Touko.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, fake Windows layout, and tap-to-click.
  imports = [
    ../../gnome
    ../../gnome/fake-windows.nix
    ../../gnome/tap-to-click.nix
  ];

}
