# Builds the linux-surface kernel for Surface devices.

{ config, pkgs, ... }:

let
  linux-surface = builtins.fetchGit {
    url = "https://github.com/linux-surface/linux-surface.git";
    ref = "master";
    rev = "ffebc8b3c062ecd553b55b465d0e7fe9a9995f82";
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
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_5.override {
    argsOverride = rec {
      version = "5.5.13";
      modDirVersion = "5.5.13"; # Needs to end in .0 if there's no .X
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
        sha256 = "1qjf18qywzrfdzwpgpf6m0w0bil8rbc9hby8473ckzvbl0a3cfqz";
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
          GPIO_SYSFS y # Required for SURFACE_SAM_HPS
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
      name = "misc-surface-config"; # Additional configs that don't easily go under a patch.
      patch = null;
      extraConfig = ''
          # Required for the build process to not fail the SURFACE_SAM_X options with "unused option".
          SERIAL_DEV_BUS y
          SERIAL_DEV_CTRL_TTYPORT y
          # Configs labeled as "misc" in the repo.
          INPUT_SOC_BUTTON_ARRAY m
          SURFACE_3_POWER_OPREGION m
          SURFACE_3_BUTTON m
          SURFACE_PRO3_BUTTON m
        '';
    }
  ];

}
