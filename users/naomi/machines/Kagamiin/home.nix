# Naomi's home configuration for Kagamiin.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome.nix
  ];

}
