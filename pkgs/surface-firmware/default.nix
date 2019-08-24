#l Firmware for Surface devices.

{ stdenv, fetchFromGitHub, unzip, surfaceModel }:

stdenv.mkDerivation {
  version = "1.0";
  name = "surface-firmware-${stdenv.lib.toLower surfaceModel}";

  src = fetchFromGitHub {
    owner = "jakeday";
    repo = "linux-surface";
    rev = "a77e9504b1ecac9201a1d9dca064111335a19fa8";
    sha256 = "0982yypsqdv98sy93siz7ac12x5bi3bdk6k5f28yzin2gc4yvm0n";
  };

  buildInputs = [ unzip ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    if [[ "${surfaceModel}" == "Pro-3" ]]; then
        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_bxt.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Pro" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v102.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_kbl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Pro-4" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v78.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_skl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Pro-2017" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v102.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_kbl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Pro-6" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v102.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_kbl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Studio" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v76.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_skl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Laptop" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v79.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_kbl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Laptop-2" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v79.zip -d $out/lib/firmware/intel/ipts/

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_kbl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == "Book" ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        unzip -o firmware/ipts_firmware_v76.zip -d $out/lib/firmware/intel/ipts/

        echo "\nInstalling i915 firmware for Surface Book...\n"
        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_skl.zip -d $out/lib/firmware/i915/
    fi

    if [[ "${surfaceModel}" == Book-2* ]]; then
        mkdir -p $out/lib/firmware/intel/ipts
        if [[ "${surfaceModel}" == "Book-2-15" ]]; then
            unzip -o firmware/ipts_firmware_v101.zip -d $out/lib/firmware/intel/ipts/
        else
            unzip -o firmware/ipts_firmware_v137.zip -d $out/lib/firmware/intel/ipts/
        fi

        mkdir -p $out/lib/firmware/i915
        unzip -o firmware/i915_firmware_kbl.zip -d $out/lib/firmware/i915/

        mkdir -p $out/lib/firmware/nvidia/gp108
        unzip -o firmware/nvidia_firmware_gp108.zip -d $out/lib/firmware/nvidia/gp108/
        mkdir -p $out/lib/firmware/nvidia/gv100
        unzip -o firmware/nvidia_firmware_gv100.zip -d $out/lib/firmware/nvidia/gv100/
    fi

    if [[ "${surfaceModel}" == "Go" ]]; then
        mkdir -p $out/lib/firmware/ath10k
        unzip -o firmware/ath10k_firmware.zip -d $out/lib/firmware/ath10k/

        # TODO Replace this in a NixOS-compatible manner.
        #if [ ! -f "/etc/init.d/surfacego-touchscreen" ]; then
        #        echo "echo \"on\" > /sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/power/control" > /etc/init.d/surfacego-touchscreen
        #        chmod 755 /etc/init.d/surfacego-touchscreen
        #        update-rc.d surfacego-touchscreen defaults
    #fi
    fi

    mkdir -p $out/lib/firmware/mrvl/
    unzip -o firmware/mrvl_firmware.zip -d $out/lib/firmware/mrvl/

    mkdir -p $out/lib/firmware/mwlwifi/
    unzip -o firmware/mwlwifi_firmware.zip -d $out/lib/firmware/mwlwifi/
  '';

  meta = with stdenv.lib; {
    description = "Firmware for the Surface ${replaceStrings [ "-" ] [ " " ] surfaceModel}`";
    homepage = https://github.com/jakeday/linux-surface;
    license = licenses.unfreeRedistributableFirmware;
    platforms = with platforms; linux;
  };

}
