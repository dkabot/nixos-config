# Naomi's home configuration for Konata.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome
  ];

}
