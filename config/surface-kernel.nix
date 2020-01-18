# Builds the linux-surface kernel for Surface devices.

{ config, pkgs, ... }:

let
  linux-surface = builtins.fetchGit {
    url = "https://github.com/linux-surface/linux-surface.git";
    ref = "master";
    rev = "f3669dbd584a8b0c109b107d09141d79710dad28";
  } + /patches/5.4;

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
      version = "5.4.6";
      modDirVersion = "5.4.6"; # Needs to end in .0 if there's no .X
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
        sha256 = "1j4916izy2nrzq7g6m5m365r60hhhx9rqcanjvaxv5x3vsy639gx";
      };
    };
  });

  # Define the kernel patches. The following URLs proved highly useful in knowing what config options are needed:
  # https://github.com/StollD/fedora-linux-surface/blob/master/config.surface
  # https://github.com/jakeday/linux-surface/issues/496
  boot.kernelPatches = [ {
      name = "ioremap_uc";
      patch = "${linux-surface}/0001-ioremap_uc.patch";
    } {
      name = "hid";
      patch = "${linux-surface}/0002-hid.patch";
    } {
      name = "surface-acpi";
      patch = "${linux-surface}/0003-surface-acpi.patch";
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
      name = "surface3-power";
      patch = "${linux-surface}/0004-surface3-power.patch";
      extraConfig = ''
          SURFACE_3_POWER_OPREGION m
          SURFACE_3_BUTTON m
          SURFACE_PRO3_BUTTON m # Does not exist?
        '';
    } {
      name = "surface-lte";
      patch = "${linux-surface}/0005-surface-lte.patch";
    } {
      name = "wifi";
      patch = "${linux-surface}/0006-wifi.patch";
    } {
      name = "surface3-spi-dma";
      patch = "${linux-surface}/0007-surface3-spi-dma.patch";
    } {
      name = "misc-surface-config"; # These configs are unrelated to any of the above modules, so splititng them out.
      patch = null;
      extraConfig = ''
          # Required for the build process to not fail the SURFACE_ACPI_X options with "unused option".
          SERIAL_DEV_BUS y
          SERIAL_DEV_CTRL_TTYPORT y
          # IPTS config options; there is no more patch for this, and they error out as "unused", but noting here anyway.
          #INTEL_IPTS m
          #INTEL_IPTS_SURFACE m
          # Camera modules. Both cause build to fail as "unused" modules, though.
          #VIDEO_IPU3_CIO2 m
          #VIDEO_IPU3_IMGU m
        '';
    }
  ];

}
