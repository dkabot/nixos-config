# Builds the Jakeday kernel for Surface devices.

{ config, pkgs, ... }:

let
  linux-surface = builtins.fetchGit {
    url = "https://github.com/qzed/linux-surface.git";
    ref = "master";
    rev = "0984748ad55175d07eeca6f5617f84b42bbc657f";
  } + /patches/5.3;

in

{
  # Apply necessary further configuration.
  imports = [
    ./surface-config.nix
  ];

  # Set the kernel version.
  boot.kernelPackages = pkgs.linuxPackages_5_3;

  # Define the kernel patches. The following URLs proved highly useful in knowing what config options are needed:
  # https://github.com/StollD/fedora-linux-surface/blob/master/config.surface
  # https://github.com/jakeday/linux-surface/issues/496
  boot.kernelPatches = [ {
      name = "surface-acpi";
      patch = "${linux-surface}/0001-surface-acpi.patch";
      extraConfig = ''
          SURFACE_ACPI m
          SURFACE_ACPI_SSH y
          SURFACE_ACPI_SSH_DEBUG_DEVICE y
          SURFACE_ACPI_SAN y
          SURFACE_ACPI_VHF y
          SURFACE_ACPI_DTX y
          SURFACE_ACPI_SID y
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
      name = "use-legacy-i915-driver";
      patch = "${linux-surface}/0008-use-legacy-i915-driver.patch";
    } {
      name = "ipts";
      patch = "${linux-surface}/0009-ipts.patch";
      extraConfig = ''
          INTEL_IPTS m
          INTEL_IPTS_SURFACE m
        '';
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
