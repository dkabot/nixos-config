# Naomi's home configuration for Kagamiin.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome.nix
  ];

  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      # Double arc-menu height to hackily account for hidpi. This would break horribly on external monitors, though...
      "org/gnome/shell/extensions/arc-menu" = {
        menu-height = 1100;
      };
      # Enable tap to click, as this touchpad really needs it.
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
      };
    };
  };

}
