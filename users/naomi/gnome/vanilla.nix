# Specific settings for Vanilla GNOME that may conflict with other configurations.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    # Apply Adwaita-dark theme.
    gtk.enable = true;
    gtk.theme.name = "Adwaita-dark";
  };

}
