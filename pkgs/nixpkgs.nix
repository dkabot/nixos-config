# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        chicago95-theme = super.callPackage ./chicago95 { };
        linux-surface-control = super.callPackage ./linux-surface-control { };
        surface-firmware-book-2-15 = super.callPackage ./surface-firmware { surfaceModel = "Book-2-15"; };
        surface-firmware-go = super.callPackage ./surface-firmware { surfaceModel = "Go"; };
      }
    ) ];

  };

}

