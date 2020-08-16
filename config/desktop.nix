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
    # 32-bit PulseAudio support for Steam, etc.
    support32Bit = true;
  };

  # 32-bit OpenGL support for Steam, etc.
  hardware.opengl.driSupport32Bit = if builtins.currentSystem == "x86_64-linux"
    then true
    else false
  ;

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

  # Enable USB for ADB/Fastboot
  services.udev.packages = [ pkgs.android-udev-rules ];

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
