# Naomi's home configuration for Mimi.

{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      # Enable fractional scaling. Scale factor itself is set in ~/.config/monitors.xml
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };

  };
}
