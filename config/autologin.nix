# Display manager autologin configuration.

{ config, displayManager, username}:

{
  # Enable 'username' autologin.
  services.xserver.displayManager.${displayManager}.autoLogin = {
    enable = true;
    user = username;
  };

}
