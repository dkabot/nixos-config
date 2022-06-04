# Naomi's home configuration for GNOME desktops.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    home.packages = with pkgs; [
      # GNOME-specific applications.
      gnome.gnome-tweaks
    ];

    # Apply default applications.
    xdg.enable = true;
    xdg.configFile."mimeapps.list".source = ../dotfiles/gnome/mimeapps.list;

    # Set text editor for git-cola.
    programs.git.includes = [
      { contents = {
        gui = {
          editor = "gnome-text-editor";
        };
      }; }
    ];

    # Various GNOME settings.
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/shell" = {
        # Set the favorites list in the Dash (or Panel).
        favorite-apps = [ "firefox.desktop" "org.gnome.Nautilus.desktop" ];
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
        picture-uri-dark = "file:///home/naomi/.config/background.png";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///home/naomi/.config/background.png";
      };
      # Set 12 hour clock format and dark color scheme.
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        clock-format = "12h";
      };
    };

  };
}
