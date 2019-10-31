{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "Sweet-gtk-theme";
  version = "2019-10-31";

  srcs = [
    # Sweet
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet";
      ref = "master";
      rev = "1bdef4cb9a0b25c6e616e7e3b65ab13a035971b1";
    })
    # Sweet-Ambar-Blue
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Ambar-Blue";
      ref = "Ambar-Blue";
      rev = "f655f5557685c075dfe7f5d47be75a5aeeadbb3b";
    })
    # Sweet-Ambar
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Ambar";
      ref = "Ambar";
      rev = "c286cc4f344405ecdf5c9f582932c1dc9563fbc4";
    })
    # Sweet-Mars
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-mars";
      ref = "mars";
      rev = "904b218b90b23c7e6f4f46d65be1083f6576c434";
    })
    # Sweet-Nova (AKA Sweet-Dark)
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Dark";
      ref = "nova";
      rev = "b1c6e87a524abc9013c113d7d1e94ba6d1df414d";
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
