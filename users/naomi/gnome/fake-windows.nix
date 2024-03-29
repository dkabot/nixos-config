# Specific settings for a "Windows n+1" GNOME-based configuration.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    # Apply Sweet-Dark theme and accompanying icon theme.
    gtk.enable = true;
    gtk.theme.name = "Sweet-Dark";
    gtk.theme.package = pkgs.sweet;
    gtk.iconTheme.name = "Sweet-Purple";
    gtk.iconTheme.package = pkgs.sweet-folders;

    home.packages = with pkgs; [
      # Additional icon themes relied upon by Sweet-Purple.
      candy-icons zafiro-icons
      # Extensions.
      gnomeExtensions.dash-to-panel gnomeExtensions.arcmenu
    ];

    dconf.enable = true;
    dconf.settings = {
      "org/gnome/shell" = {
        # Enable extensions.
        enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "dash-to-panel@jderose9.github.com" "arcmenu@arcmenu.com" ];
      };
      # Enable Minimize and Maximize buttons.
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      # Apply shell theme.
      "org/gnome/shell/extensions/user-theme" = {
        name = "Sweet-Dark";
      };
      # Dash to Panel settings.
      "org/gnome/shell/extensions/dash-to-panel" = {
        panel-size = 40; # Panel height.
        appicon-margin = 7; # Distance between favorite/task icons.
        click-action = "TOGGLE-SHOWPREVIEW"; # On task click, toggle minimize/shown if single window, or show previews if multiple.
        show-window-previews-timeout = 500; # Wait 500ms to show previews on hover.
        leave-timeout = 500; # Wait 500ms to stop showing previews on hover exit.
        window-preview-animation-time = 150; # 150ms animation time when showing or hiding window previews.
        trans-use-custom-bg = true; # Enable custom panel background color (versus inheriting from shell theme).
        trans-bg-color = "#221a3f"; # Custom panel background color value.
        trans-use-custom-opacity = true; # Enable custom panel transparency (versus inheriting from shell theme).
        trans-panel-opacity = 0.65; # 65% panel transparency.
        isolate-monitors = true; # Keep tasks on different monitors separate.
        scroll-panel-action = "NOTHING"; # Don't switch workspaces on panel scroll.
        scroll-icon-action = "NOTHING"; # Don't change application windows on icon scroll.
        hot-keys = true; # Enable Super + <num> hotkeys.
        show-show-apps-button = false; # Hide Applications button, for Arc-Menu
        panel-element-positions = ''{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'';
      };
      # Arc Menu settings.
      "org/gnome/shell/extensions/arcmenu" = {
        default-menu-view = "Categories_List"; # Show full application menu instead of pins.
        menu-hotkey = "Super_L"; # Open with left super key.
        multi-monitor = true; # Enable multi monitor support.
        show-software-shortcut = false; # Hide GNOME Software shortcut.
      };
    };
  };
}
