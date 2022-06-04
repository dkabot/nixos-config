# Naomi's home configuration for Konata.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings and fake Windows layout.
  imports = [
    ../../gnome
    ../../gnome/fake-windows.nix
  ];

}
