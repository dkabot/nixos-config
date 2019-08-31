# Naomi's home configuration for GNOME desktops.
{ config, ... }:

{
  home-manager.users.naomi = {
    # Apply Adwaita-dark theme, because it is nice.
    gtk.enable = true;
    gtk.theme.name = "Adwaita-dark";

    # Various GNOME settings.
    dconf.enable = true;
    dconf.settings = {
      # Set the favorites list in the Dash.
      "org/gnome/shell" = {
        favorite-apps = [ "firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop" ];
      };
      # Prevent automatic sleep while on AC power.
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
      };
      # Sort folders before files in Nautilus and the file chooser.
      "org/gnome/nautilus/preferences" = {
        sort-directories-first = true;
      };
      "org/gtk/settings/file-chooser" = {
        sort-directories-first = true;
      };
      # Set desktop and lock screen backgrounds.
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/naomi/.config/background.png";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///home/naomi/.config/background.png";
      };
    };

  };
}
