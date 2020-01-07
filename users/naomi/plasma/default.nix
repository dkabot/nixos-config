# Naomi's home configuration for KDE Plasma desktops.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {

    home.packages = with pkgs; [
      # Kvantum-manager for Kvantum theme support.
      libsForQt5.qtstyleplugin-kvantum
      # Theme packages (home-manager gtk module uses dconf and thus won't work).
      sweet sweet-folders candy-icons zafiro-icons breeze-enhanced
    ];

    # Apply default applications.
    #xdg.enable = true;
    #xdg.configFile."mimeapps.list".source = ../dotfiles/plasma/mimeapps.list;

  };
}
