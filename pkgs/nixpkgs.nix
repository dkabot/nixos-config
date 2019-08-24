# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        linux-surface-control = import ./linux-surface-control { inherit (self) lib fetchFromGitHub rustPlatform; };
        surface-firmware-book-2-15 = import ./surface-firmware { inherit (self) stdenv fetchFromGitHub unzip; surfaceModel = "Book-2-15"; };
        surface-firmware-go = import ./surface-firmware { inherit (self) stdenv fetchFromGitHub unzip; surfaceModel = "Go"; };
      }
    ) ];

  };

}

