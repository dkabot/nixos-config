# Common desktop configuration; common between any graphical environments.

{ config, pkgs, ... }:

{
  # Apply standard config.
  imports = [
    ./default.nix
  ];

  # Enable Bluetooth.
  hardware.bluetooth.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # Full PulseAudio package is necessary for bluetooth audio support.
    package = pkgs.pulseaudioFull;
    # Add extra modules for nicer Bluetooth codec support.
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  # Enable X (or Wayland, depending, but it's the same setting).
  services.xserver.enable = true;

  # Remove 'xterm' entry in display manager
  services.xserver.desktopManager.xterm.enable = false;

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true;
    clickMethod = "clickfinger";
    naturalScrolling = true;
    tapping = true;
  };

  # Enable touch scrolling in Firefox.
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # Additional fonts.
  fonts.fonts = with pkgs; [
    ipafont # Japanese
    twemoji-color-font # Emoji
  ];

}
