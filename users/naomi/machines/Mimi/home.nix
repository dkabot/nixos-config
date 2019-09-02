# Naomi's home configuration for Mimi.

{ config, pkgs, ... }:

{
  # Apply base GNOME settings.
  imports = [
    ../../gnome.nix
  ];

  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      # Enable fractional scaling. Scale factor itself is set in ~/.config/monitors.xml
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
      # Double arc-menu height to hackily account for hidpi. This would break horribly on external monitors, though...
      "org/gnome/shell/extensions/arc-menu" = {
        menu-height = 1100;
      };
    };
  };

}
