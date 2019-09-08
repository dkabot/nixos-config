# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        # Surface-related packages
        linux-surface-control = super.callPackage ./linux-surface-control { };
        surface-firmware-book-2-15 = super.callPackage ./surface-firmware { surfaceModel = "Book-2-15"; };
        surface-firmware-go = super.callPackage ./surface-firmware { surfaceModel = "Go"; };
        # Theming
        chicago95 = super.callPackage ./chicago95 { };
        sweet = super.callPackage ./sweet { };
        candy-icons = super.callPackage ./candy-icons { };
        sweet-folders = super.callPackage ./sweet-folders { };
      }
    ) ];

  };

}

