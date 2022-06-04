# Naomi's home configuration for Vivio.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings and tap-to-click.
  imports = [
    ../../gnome
    ../../gnome/tap-to-click.nix
  ];

}
