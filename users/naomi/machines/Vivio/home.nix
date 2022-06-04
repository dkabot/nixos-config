# Naomi's home configuration for Vivio.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, the Vanilla layout, and tap-to-click.
  imports = [
    ../../gnome
    ../../gnome/vanilla.nix
    ../../gnome/tap-to-click.nix
  ];

}
