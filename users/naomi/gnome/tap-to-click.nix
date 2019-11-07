# Enable tap-to-click on touchpads, as GNOME doesn't obey the system-side setting.
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
      };
    };
  };
}
