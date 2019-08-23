# Naomi's standard home configuration for all systems.
{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
  };

in

{
  imports = [
    "${home-manager}/nixos"
    # Dynamically importing per-machine home configs would be cool but looks infeasible.
    #(../../machines + "/${config.networking.hostName}" + /naomi/home.nix)
  ];

  home-manager.users.naomi = {
    home.packages = [
      pkgs.discord pkgs.slack
      pkgs.meld
      pkgs.filezilla
      pkgs.neofetch
    ];

    programs.firefox.enable = true;

    programs.git = {
      enable = true;
      userName = "dkabot";
      userEmail = "1316469+dkabot@users.noreply.github.com";
    };

    home.sessionVariables = {
      EDITOR = "nano";
    };

    gtk.enable = true;
    gtk.theme.name = "Adwaita-dark";

    dconf.enable = true;
    dconf.settings = {
      "org/gnome/shell" = {
         favorite-apps = ["firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop"];
      };
      "apps/gnome-power-manager/timeout" = {
         sleep_computer_ac = 0;
      };
    };

    xdg.enable = true;
    xdg.configFile."mimeapps.list".source = ./dotfiles/mimeapps.list;

  };
}
