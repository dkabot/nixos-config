# Naomi's home configuration for Terra.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, plus enables fractional scaling.
  imports = [
    ../../gnome
    ../../gnome/tap-to-click.nix
  ];

}
