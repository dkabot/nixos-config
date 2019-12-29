# Additional configuration from the linux-surface kernel repos for Surface devices.
# This file is separate in the event of a device that benefits from the config but does not require the entire kernel.

{ config, pkgs, ... }:

{
  # Power management config from linux-surface repo.
  config.powerManagement.powerDownCommands = ''
    # Disable bluetooth if no device is connected
    if ps cax | grep bluetoothd && ! bluetoothctl info; then
      bluetoothctl power off
    fi

    # handle wifi issues
    ${pkgs.kmod}/bin/modprobe -r mwifiex_pcie;
    ${pkgs.kmod}/bin/modprobe -r mwifiex;
    ${pkgs.kmod}/bin/modprobe -r cfg80211;
  '';

  config.powerManagement.resumeCommands = ''
    # Restart bluetooth
    if ps cax | grep bluetoothd; then
      bluetoothctl power on
    fi

    # handle wifi issues: complete cycle
    ${pkgs.kmod}/bin/modprobe cfg80211;
    ${pkgs.kmod}/bin/modprobe mwifiex;
    ${pkgs.kmod}/bin/modprobe mwifiex_pcie;
    echo 1 > /sys/bus/pci/rescan

    if [ -x "$(command -v nmcli)" ]  && [ "$(nmcli net)" = "enabled" ]; then
      nmcli net off
      nmcli net on
    fi
  '';

  # Modprobe config from linux-surface repo.
  config.boot.extraModprobeConfig = ''
    # ath10k.conf
    options ath10k_core skip_otp=y
    # snd-hda-intel.conf
    options snd-hda-intel single_cmd=1
    options snd-hda-intel probe_mask=1
    options snd-hda-intel model=basic
    # soc-button-array.conf
    softdep soc_button_array pre: pinctrl_sunrisepoint
  '';

  # Initramfs config from linux-surface repo.
  config.boot.initrd.kernelModules = [
    "hid"
    "hid_sensor_hub"
    "i2c_hid"
    "hid_generic"
    "usbhid"
    "hid_multitouch"
    "intel_ipts"
    "surface_sam_ssh"
    "surface_sam_san"
    "surface_sam_vhf"
  ];

}
