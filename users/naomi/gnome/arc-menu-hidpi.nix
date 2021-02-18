# Double arc-menu height to hackily account for hidpi. This would break horribly on external monitors, though...
{ config, pkgs, ... }:

{
  home-manager.users.naomi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/shell/extensions/arcmenu" = {
        menu-height = 1100;
      };
    };
  };
}
