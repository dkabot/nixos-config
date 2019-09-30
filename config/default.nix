# Shared NixOS configuration. All systems should utilize what is within this file.

{ config, pkgs, ... }:

{
  imports = [
    # Apply nixpkgs configuration.
    ../pkgs/nixpkgs.nix
    # Bring in relevant user configuration.
    ../users
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  # Use a tmpfs for /tmp.
  boot.tmpOnTmpfs = true;

  # Enable NTFS support.
  boot.supportedFilesystems = [ "ntfs" ];
  # Enable ExFAT support.
  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

  # Set the time zone.
  time.timeZone = "America/New_York";

  # Automatically optimize the Nix store.
  nix.autoOptimiseStore = true;

  # Use sandboxing when building.
  nix.useSandbox = true;

  # Add basic packages for system-wide scope.
  environment.systemPackages = with pkgs; [
    htop git mkpasswd unzip wget
  ];

}
