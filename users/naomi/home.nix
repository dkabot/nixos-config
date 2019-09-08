# Naomi's standard home configuration for all systems.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    # User-scope packages; not neeeded system-wide.
    home.packages = with pkgs; [
      # Electron
      discord slack bitwarden
      # GUI Utilities
      meld filezilla syncthing-gtk gimp
      # Terminal Utilities
      neofetch
      # Games
      multimc steam lutris retroarch
    ];

    # Firefox could be added as a package above, but this allows for expansion if desired.
    programs.firefox.enable = true;

    # Enable SyncThing service.
    services.syncthing.enable = true;

    # Basic git configuration.
    programs.git = {
      enable = true;
      userName = "dkabot";
      userEmail = "1316469+dkabot@users.noreply.github.com";
    };

    home.sessionVariables = {
      EDITOR = "nano";
    };

    xdg.enable = true;
    xdg.configFile."mimeapps.list".source = ./dotfiles/mimeapps.list;
    xdg.configFile."background.png".source = ./dotfiles/background.png;

  };
}
