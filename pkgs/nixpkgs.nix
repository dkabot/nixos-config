# nixpkgs configuration file

{ config, lib, ... }:

{
  nixpkgs = {
    # Enable nonfree software. :(
    config.allowUnfree = true;

    overlays = [ (self: super: {
        # GNOME Extensions
        gnomeExtensions = super.recurseIntoAttrs {
          arc-menu = super.callPackage ./arc-menu { };
          dash-to-panel = super.gnomeExtensions.dash-to-panel.overrideAttrs ( old: rec {
            name = "${pname}-${version}"; # Need to manually specify, or it will use the prior -19 name.
            pname = "gnome-shell-dash-to-panel";
            version = "22";
            src = super.fetchFromGitHub {
              owner = "home-sweet-gnome";
              repo = "dash-to-panel";
              rev = "v${version}";
              sha256 = "05v17887s44p6y17lf8aa2hfak84x1qifcq9d9c6y59mkyjs6g7n";
            };
          });
        };
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

