# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        # Surface-related packages
        linux-surface-control = super.callPackage ./linux-surface-control { };
        surface-firmware = super.callPackage ./surface-firmware { };
        # Theming
        chicago95 = super.callPackage ./chicago95 { };
        sweet = super.callPackage ./sweet { };
        candy-icons = super.callPackage ./candy-icons { };
        sweet-folders = super.callPackage ./sweet-folders { };
        # Applications
        sidequest = super.callPackage ./sidequest { };
      }
    ) ];

    # Enable retroarch cores; does nothing if retroarch is not installed.
    config.retroarch = {
      enable4do = true;
      enableBeetlePCEFast = true;
      enableBeetlePSX = true;
      enableBeetleSaturn = true;
      enableBsnesMercury = true;
      enableDesmume = true;
      enableDolphin = true;
      enableFBA = true;
      enableFceumm = true;
      enableGambatte = true;
      enableGenesisPlusGX = true;
      enableHiganSFC = true;
      enableMAME = true;
      enableMGBA = true;
      enableMupen64Plus = true;
      enableNestopia = true;
      enableParallelN64 = true;
      enablePicodrive = true;
      enablePrboom = true;
      enablePPSSPP = true;
      enableQuickNES = true;
      enableReicast = true;
      enableScummVM = true;
      enableSnes9x = true;
      enableSnes9xNext = true;
      enableStella = true;
      enableVbaNext = true;
      enableVbaM = true;
    };

  };
}

