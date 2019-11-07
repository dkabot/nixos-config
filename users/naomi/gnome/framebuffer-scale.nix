# Enables fractional scaling. Scale factor itself is set in ~/.config/monitors.xml
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };
  };
}
