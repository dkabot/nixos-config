{ stdenv, lib, fetchFromGitHub, gtk3 }:

stdenv.mkDerivation rec {
  pname = "candy-icons";
  version = "5df1fcdf5994ced19d612f136adda75e570db6ca";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = pname;
    rev = version;
    sha256 = "0b65m0acz6c20n3sw0hklbfmb5fxnwamrsgrp2nimkq730bqzn2m";
  };

  nativeBuildInputs = [ gtk3 ];

  installPhase = ''
     mkdir -p $out/share/icons/candy-icons
     mv * $out/share/icons/candy-icons/
  '';

  postFixup = ''
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
  '';

  meta = with lib; {
    description = "Sweet gradient icons.";
    homepage = https://github.com/EliverLara/candy-icons;
    platforms = platforms.linux;
  };
}
