# Naomi's home configuration for Kagamiin.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome.nix
  ];

  # Double arc-menu height to hackily account for hidpi. This would break horribly on external monitors, though...
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/shell/extensions/arc-menu" = {
        menu-height = 1100;
      };
    };
  };

}
