# Naomi's standard home configuration for all systems.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    # User-scope packages; not neeeded system-wide.
    # The if statement is an ugly hack but it seems to work?
    home.packages = with pkgs;
    # Packages for x86_64
    if builtins.currentSystem == "x86_64-linux" then
    [
      # Electron
      discord slack bitwarden etcher
      # GUI Utilities
      meld filezilla gimp sidequest cura
      # Terminal Utilities
      neofetch steam-run
      # Games
      multimc steam lutris #retroarch
    ]
    # Packages for aarch64 (only other option atm).
    else [
      # GUI Utilities
      meld filezilla gimp
      # Terminal Utilities
      neofetch
      # Games
      multimc
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

    # Copy wallpaper image into .config
    xdg.enable = true;
    xdg.configFile."background.png".source = ./dotfiles/background.png;

  };
}
