# Naomi's home configuration for Mimi.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, fake Windows layout, fractional scaling, and tap-to-click.
  imports = [
    ../../gnome
    ../../gnome/fake-windows.nix
    ../../gnome/framebuffer-scale.nix
    ../../gnome/tap-to-click.nix
  ];

}
