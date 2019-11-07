# Make Left Alt into Left Super for the sake of GNOME, when there is no Left Super key.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "terminate:ctrl_alt_bksp" "altwin:swap_lalt_lwin" ]; # Terminate shortcut was set by default.
      };
    };
  };
}
