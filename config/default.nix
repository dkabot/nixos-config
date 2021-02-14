# Shared NixOS configuration. All systems should utilize what is within this file.

{ config, pkgs, ... }:

{
  imports = [
    # Apply nixpkgs configuration.
    ../pkgs/nixpkgs.nix
    # Bring in relevant user configuration.
    ../users
  ];

  # Use a tmpfs for /tmp.
  boot.tmpOnTmpfs = true;

  # Enable NTFS support.
  boot.supportedFilesystems = [ "ntfs" ];

  # Set the time zone.
  time.timeZone = "America/New_York";

  # Automatically optimize the Nix store.
  nix.autoOptimiseStore = true;

  # Use sandboxing when building.
  nix.useSandbox = true;

  # Add basic packages for system-wide scope.
  environment.systemPackages = with pkgs; [
    htop git mkpasswd unzip wget p7zip usbutils
  ];

}
