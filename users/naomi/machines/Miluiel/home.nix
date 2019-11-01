# Naomi's home configuration for Miluiel.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome.nix
  ];

  # Make Left Alt into Left Win for the sake of GNOME, since there is no Win key.
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "terminate:ctrl_alt_bksp" "altwin:swap_lalt_lwin" ]; # Terminate shortcut was set by default.
      };
    };
  };

}
