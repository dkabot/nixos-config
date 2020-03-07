# Naomi's home configuration for Mimi.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, plus enables fractional scaling.
  imports = [
    ../../gnome
    ../../gnome/framebuffer-scale.nix
    ../../gnome/tap-to-click.nix
  ];

}
