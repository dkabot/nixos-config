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
      firefox-wayland meld filezilla gimp sidequest cura prusa-slicer woeusb git-cola
      # Terminal Utilities
      neofetch steam-run
      # Games
      prismlauncher steam lutris #retroarch
    ]
    # Packages for aarch64 (only other option atm).
    else
    [
      # GUI Utilities
      firefox-wayland meld filezilla gimp
      # Terminal Utilities
      neofetch
      # Games
      prismlauncher
    ];

    # Firefox could be added as a package above, and currently must be to use `firefox-wayland`. TODO reopen issue on home-manager
    #programs.firefox = {
    #  enable = true;
    #  # Set up for Wayland usage
    #  package = pkgs.firefox-wayland;
    #};

    # Basic git configuration.
    programs.git = {
      enable = true;
      userName = "dkabot";
      userEmail = "1316469+dkabot@users.noreply.github.com";
    };

    home.sessionVariables = {
      EDITOR = "nano";
      # For Firefox
      MOZ_ENABLE_WAYLAND = 1;
    };

    # Previously implied default, needs to remain such.
    home.stateVersion = "18.09";

    # Copy wallpaper image into .config
    xdg.enable = true;
    xdg.configFile."background.png".source = ./dotfiles/background.png;

  };
}
