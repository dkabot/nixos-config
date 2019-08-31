{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "Sweet-gtk-theme";
  version = "1.10.5";

  srcs = [
    # Sweet
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet";
      ref = "master";
      rev = "50380d25b62a630548674dad6d994a23f4397fd3";
    })
    # Sweet-Ambar-Blue
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Ambar-Blue";
      ref = "Ambar-Blue";
      rev = "6422fe9b16d6c7256d74b6b0e4ccdcaa9c9ed295";
    })
    # Sweet-Ambar
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Ambar";
      ref = "Ambar";
      rev = "84850de5b3c41525e3a2524d13bdae0491954ab3";
    })
    # Sweet-Mars
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-mars";
      ref = "mars";
      rev = "97618727ad6221954a7605c8a528db9cfd5cc6f7";
    })
    # Sweet-Nova (AKA Sweet-Dark)
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Dark";
      ref = "nova";
      rev = "6aea872746c1d9173decfa3a339ac5cd15318f0f";
    })
  ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/themes
    mv Sweet* $out/share/themes/
  '';

  meta = with stdenv.lib; {
    description = "Light and dark colorful Gtk3.20+ theme.";
    homepage = https://github.com/EliverLara/Sweet;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
