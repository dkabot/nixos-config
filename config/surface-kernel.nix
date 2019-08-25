# Builds the Jakeday kernel for Surface devices.

{ config, pkgs, ... }:

let
  linux-surface = builtins.fetchGit {
    url = "https://github.com/qzed/linux-surface.git";
    ref = "v5.2";
    rev = "206e3255dddc35026883eee44aa7ba7c9f3081e9";
  } + /patches/5.2;

in

{
  # Apply necessary further configuration.
  imports = [
    ./surface-config.nix
  ];

  # Set the kernel version.
  boot.kernelPackages = pkgs.linuxPackages_5_2;

  # Define the kernel patches. The following URLs proved highly useful in knowing what config options are needed:
  # https://github.com/StollD/fedora-linux-surface/blob/master/config.surface
  # https://github.com/jakeday/linux-surface/issues/496
  boot.kernelPatches = [ {
      name = "surface-acpi";
      patch = "${linux-surface}/0001-surface-acpi.patch";
      extraConfig = ''
          SURFACE_ACPI m
          SURFACE_ACPI_SSH y
          SURFACE_ACPI_SSH_DEBUG_DEVICE n
          SURFACE_ACPI_SAN y
          SURFACE_ACPI_VHF y
          SURFACE_ACPI_DTX y
          SURFACE_ACPI_SID y
        '';
    } {
      name = "suspend";
      patch = "${linux-surface}/0002-suspend.patch";
    } {
      name = "buttons";
      patch = "${linux-surface}/0003-buttons.patch";
    } {
      name = "cameras";
      patch = "${linux-surface}/0004-cameras.patch";
    } {
      name = "ipts";
      patch = "${linux-surface}/0005-ipts.patch";
      extraConfig = ''
          INTEL_IPTS m
        '';
    } {
      name = "hid";
      patch = "${linux-surface}/0006-hid.patch";
    } {
      name = "sdcard-reader";
      patch = "${linux-surface}/0007-sdcard-reader.patch";
    } {
      name = "wifi";
      patch = "${linux-surface}/0008-wifi.patch";
    } {
      name = "surface3-power";
      patch = "${linux-surface}/0009-surface3-power.patch";
      extraConfig = ''
          SURFACE_3_POWER_OPREGION m
        '';
    } {
      name = "mwlwifi";
      patch = "${linux-surface}/0010-mwlwifi.patch";
      # MWLWIFI is not set
    } {
      name = "surface-lte";
      patch = "${linux-surface}/0011-surface-lte.patch";
    } {
      name = "surfacebook2-dgpu";
      patch = "${linux-surface}/0012-surfacebook2-dgpu.patch";
      extraConfig = ''
          SURFACE_BOOK2_DGPU_HPS m
        '';
    } {
      name = "misc-surface-config"; # I don't know if these configs are related to any of the above modules, so splititng them out.
      patch = null;
      extraConfig = ''
          MEDIA_CEC_RC y
          NET_DSA_MV88E6060 m
          # Required for the build process to not fail the SURFACE_ACPI_X options with "unused option".
          SERIAL_DEV_BUS y
          SERIAL_DEV_CTRL_TTYPORT y
          # The following two cause build to fail. The first gives "repeated question", the second "unused option". In stock kernel, former defaults to 'm', latter does not exist.
          #NET_DSA_TAG_TRAILER y
          #OVERLAY_FS_NFS_EXPORT n
        '';
    }
  ];

}
