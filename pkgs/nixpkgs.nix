# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        surface-firmware-book-2-15 = import ./surface-firmware { inherit (self) stdenv lib fetchFromGitHub dmidecode unzip; surfaceModel = "Book-2-15"; };
        surface-firmware-go = import ./surface-firmware { inherit (self) stdenv lib fetchFromGitHub dmidecode unzip; surfaceModel = "Go"; };
      }
    ) ];

  };

}

