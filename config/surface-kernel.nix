# Builds the qzed kernel for Surface devices.

{ config, pkgs, ... }:

let
  linux-surface = builtins.fetchGit {
    url = "https://github.com/qzed/linux-surface.git";
    ref = "master";
    rev = "9e132617b877f6dbc8c042e493c2d6ed5ddf45ea";
  } + /patches/5.3;

in

{
  # Apply necessary further configuration.
  imports = [
    ./surface-config.nix
  ];

  # Set the kernel version.
  #boot.kernelPackages = pkgs.linuxPackages_5_3;
  # Template for if a specific subversion is necessary.
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_3.override {
    argsOverride = rec {
      version = "5.3.15";
      modDirVersion = "5.3.15"; # Needs to end in .0 if there's no .X
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
        sha256 = "15qidl06lyfylx1b43b4wz2zfkr4000bkr7ialslmb7yi7mamj6f";
      };
    };
  });

  # Define the kernel patches. The following URLs proved highly useful in knowing what config options are needed:
  # https://github.com/StollD/fedora-linux-surface/blob/master/config.surface
  # https://github.com/jakeday/linux-surface/issues/496
  boot.kernelPatches = [ {
      name = "surface-acpi";
      patch = "${linux-surface}/0001-surface-acpi.patch";
      extraConfig = ''
          SURFACE_SAM m
          SURFACE_SAM_SAN m
          SURFACE_SAM_SSH m
          SURFACE_SAM_SSH_DEBUG_DEVICE y
          SURFACE_SAM_VHF m
          SURFACE_SAM_DTX m
          SURFACE_SAM_SID m
        '';
    } {
      name = "buttons";
      patch = "${linux-surface}/0002-buttons.patch";
    } {
      name = "surfacebook2-dgpu";
      patch = "${linux-surface}/0003-surfacebook2-dgpu.patch";
      extraConfig = ''
          SURFACE_BOOK2_DGPU_HPS m
        '';
    } {
      name = "hid";
      patch = "${linux-surface}/0004-hid.patch";
    } {
      name = "surface3-power";
      patch = "${linux-surface}/0005-surface3-power.patch";
      extraConfig = ''
          SURFACE_3_POWER_OPREGION m
        '';
    } {
      name = "surface-lte";
      patch = "${linux-surface}/0006-surface-lte.patch";
    } {
      name = "wifi";
      patch = "${linux-surface}/0007-wifi.patch";
    } {
      name = "legacy-i915";
      patch = "${linux-surface}/0008-legacy-i915.patch";
    } {
      name = "ipts";
      patch = "${linux-surface}/0009-ipts.patch";
      extraConfig = ''
          INTEL_IPTS m
          INTEL_IPTS_SURFACE m
        '';
    } {
      name = "ioremap_uc";
      patch = "${linux-surface}/0010-ioremap_uc.patch";
    } {
      name = "misc-surface-config"; # These configs are unrelated to any of the above modules, so splititng them out.
      patch = null;
      extraConfig = ''
          # Required for the build process to not fail the SURFACE_ACPI_X options with "unused option".
          SERIAL_DEV_BUS y
          SERIAL_DEV_CTRL_TTYPORT y
          # Camera modules. Both cause build to fail as "unused" modules, though.
          #VIDEO_IPU3_CIO2 m
          #VIDEO_IPU3_IMGU m
        '';
    }
  ];

}
