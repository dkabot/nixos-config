# Naomi's user account configuration.

{ config, ... }:

{
  # Enable 'naomi' autologin.
  services.xserver.displayManager.gdm.autoLogin = {
    enable = true;
    user = "naomi";
  };

}
