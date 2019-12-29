# Firmware for Surface devices.

{ stdenv, fetchFromGitHub, unzip }:

stdenv.mkDerivation {
  version = "1.1";
  name = "surface-firmware";

  srcs = [
    # Latest master
    (fetchFromGitHub {
      owner = "linux-surface";
      name = "master";
      repo = "linux-surface";
      rev = "0984748ad55175d07eeca6f5617f84b42bbc657f";
      sha256 = "0ivfw1p8w9qz32kl2qcc5prywjaydaicvdbxclf4jydrf39j3lfh";
    })
    # Last commit before extra firmwares were removed
    (fetchFromGitHub {
      owner = "linux-surface";
      name = "legacy-firmware";
      repo = "linux-surface";
      rev = "8c3acded2d6eedd41ac7b3f126a49e4627879248";
      sha256 = "12i4q09d5hkhwgccg7lv6dvznsgnsds5iq0zl8s5gdrw3vk0s121";
    })
  ];

  sourceRoot = ".";

  buildInputs = [ unzip ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/lib/firmware
    cp -r master/firmware/* $out/lib/firmware/
    mkdir -p $out/lib/firmware/ath10k
    unzip -o legacy-firmware/firmware/ath10k_firmware.zip -d $out/lib/firmware/ath10k/
  '';

  meta = with stdenv.lib; {
    description = "Firmware for Surface devices";
    homepage = https://github.com/linux-surface/linux-surface;
    license = licenses.unfreeRedistributableFirmware;
    platforms = with platforms; linux;
  };

}
