# GDM autologin configuration.

{ config, username }:

{
  # Enable 'username' autologin.
  services.xserver.displayManager.gdm.autoLogin = {
    enable = true;
    user = username;
  };

}
