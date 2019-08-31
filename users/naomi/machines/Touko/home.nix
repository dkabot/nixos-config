# Naomi's home configuration for Touko.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome.nix
  ];

}
