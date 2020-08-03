# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        # Surface-related packages
        surface-control = super.callPackage ./surface-control { };
        surface-firmware = super.callPackage ./surface-firmware { };
        # Theming
        candy-icons = super.callPackage ./candy-icons { };
        sweet-folders = super.callPackage ./sweet-folders { };
      }
    ) ];

  };
}

