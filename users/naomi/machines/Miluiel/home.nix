# Naomi's home configuration for Miluiel.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings, plus swaps Left Alt with Left Super.
  imports = [
    ../../gnome
    ../../gnome/left-alt-as-super.nix
  ];

}
