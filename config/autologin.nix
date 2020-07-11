# Display manager autologin configuration.

{ config, username}:

{
  # Enable 'username' autologin.
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = username;
  };

}
