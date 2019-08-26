# Naomi's standard home configuration for all systems.
{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "eb1b86a5ec7baf1a1ce2c277d568a8751c24a7ee";
    #ref = "release-19.09";
  };

in

{
  imports = [
    # Import home-manager itself.
    "${home-manager}/nixos"
    # Dynamically importing per-machine home configs would be cool but looks infeasible.
    #(../../machines + "/${config.networking.hostName}" + /naomi/home.nix)
  ];

  home-manager.users.naomi = {
    # User-scope packages; not neeeded system-wide.
    home.packages = with pkgs; [
      discord slack bitwarden
      meld filezilla
      neofetch
    ];

    # Firefox could be added as a package above, but this allows for expansion if desired.
    programs.firefox.enable = true;

    # Basic git configuration.
    programs.git = {
      enable = true;
      userName = "dkabot";
      userEmail = "1316469+dkabot@users.noreply.github.com";
    };

    home.sessionVariables = {
      EDITOR = "nano";
    };

    # Apply Adwaita-dark theme, because it is nice.
    gtk.enable = true;
    gtk.theme.name = "Adwaita-dark";

    # Various GNOME settings.
    dconf.enable = true;
    dconf.settings = {
      # Set the favorites list in the Dash.
      "org/gnome/shell" = {
        favorite-apps = ["firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop"];
      };
      # Prevent automatic sleep while on AC power.
      "apps/gnome-power-manager/timeout" = {
        sleep_computer_ac = 0;
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

    xdg.enable = true;
    xdg.configFile."mimeapps.list".source = ./dotfiles/mimeapps.list;
    xdg.configFile."background.png".source = ./dotfiles/background.png;

  };
}