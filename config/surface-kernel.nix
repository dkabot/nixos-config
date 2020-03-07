# Builds the linux-surface kernel for Surface devices.

{ config, pkgs, ... }:

let
  linux-surface = builtins.fetchGit {
    url = "https://github.com/linux-surface/linux-surface.git";
    ref = "master";
    rev = "0287820f4f4e352628f526c401cf57c89cf0d9dd";
  } + /patches/5.5;

in

{
  # Apply necessary further configuration.
  imports = [
    ./surface-config.nix
  ];

  # Set the kernel version.
  #boot.kernelPackages = pkgs.linuxPackages_5_4;
  # Template for if a specific subversion is necessary.
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_4.override {
    argsOverride = rec {
      version = "5.5.8";
      modDirVersion = "5.5.8"; # Needs to end in .0 if there's no .X
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
        sha256 = "01pw0gfafbsds6vq26qynffwvqm4khs953k1b6rrz8wris9zddp5";
      };
    };
  });

  # Define the kernel patches. The following URLs proved highly useful in knowing what config options are needed:
  # https://github.com/StollD/fedora-linux-surface/blob/master/config.surface
  # https://github.com/jakeday/linux-surface/issues/496
  boot.kernelPatches = [ {
      name = "surface3-power";
      patch = "${linux-surface}/0001-surface3-power.patch";
      extraConfig = ''
          SURFACE_3_POWER_OPREGION m
          SURFACE_3_BUTTON m
          SURFACE_PRO3_BUTTON m
        '';
    } {
      name = "surface3-spi";
      patch = "${linux-surface}/0002-surface3-spi.patch";
    } {
      name = "surface3-oemb";
      patch = "${linux-surface}/0003-surface3-oemb.patch";
    } {
      name = "surface-sam";
      patch = "${linux-surface}/0004-surface-sam.patch";
      extraConfig = ''
          SURFACE_SAM m
          SURFACE_SAM_SSH m
          SURFACE_SAM_SSH_DEBUG_DEVICE y
          SURFACE_SAM_SAN m
          SURFACE_SAM_VHF m
          SURFACE_SAM_DTX m
          SURFACE_SAM_HPS m
          SURFACE_SAM_SID m
          SURFACE_SAM_SID_GPELID m
          SURFACE_SAM_SID_PERFMODE m
          SURFACE_SAM_SID_VHF m
          SURFACE_SAM_SID_POWER m
        '';
    } {
      name = "surface-lte";
      patch = "${linux-surface}/0005-surface-lte.patch";
    } {
      name = "wifi";
      patch = "${linux-surface}/0006-wifi.patch";
    } {
      name = "ipts";
      patch = "${linux-surface}/0007-ipts.patch";
      extraConfig = ''
          TOUCHSCREEN_IPTS m
        '';
    } {
      name = "misc-surface-config"; # These configs are unrelated to any of the above modules, so splititng them out.
      patch = null;
      extraConfig = ''
          # Required for the build process to not fail the SURFACE_ACPI_X options with "unused option".
          SERIAL_DEV_BUS y
          SERIAL_DEV_CTRL_TTYPORT y
        '';
    }
  ];

}
