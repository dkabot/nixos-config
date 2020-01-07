{ stdenv, fetchFromGitHub, extra-cmake-modules, kconfigwidgets, kcoreaddons, kdecoration, kguiaddons, kwindowsystem, qtbase, qtx11extras }:

stdenv.mkDerivation rec {
  pname = "breeze-enhanced";
  version = "611e460cb371b816e86a5c103258460fb821f5bd";

  src = fetchFromGitHub {
    owner = "tsujan";
    repo = "BreezeEnhanced";
    rev = version;
    sha256 = "13vpzkpsgx5ad2kcn4p0lrshm69y6qk0hrilidvimix1948dc7bz";
  };

  patches = [ ./sweet_colors.patch ];

  nativeBuildInputs = [ extra-cmake-modules ];
  buildInputs = [ kconfigwidgets kcoreaddons kdecoration kguiaddons kwindowsystem qtbase qtx11extras ];

  # Make this a fixed-output derivation
  #outputHashMode = "recursive";
  #outputHashAlgo = "sha256";
  #ouputHash = "2c2def57092a399aa1c450699cbb8639f47d751157b18db17";

  meta = with stdenv.lib; {
    description = "A fork of KDE Breeze decoration with additional options";
    homepage = https://github.com/tsujan/BreezeEnhanced;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
