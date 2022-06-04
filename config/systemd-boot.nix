# Use the systemd-boot EFI boot loader.

{ config, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 3;
  # Only set this on x86_64.
  boot.loader.efi.canTouchEfiVariables = lib.mkIf (builtins.currentSystem == "x86_64-linux") true;
}
