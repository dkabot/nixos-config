{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "Sweet-gtk-theme";
  version = "2019-12-20";

  srcs = [
    # Sweet
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet";
      ref = "master";
      rev = "2d861cab32841b5ada7a84373d8a2d9f159dd5fe";
    })
    # Sweet-Ambar-Blue
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Ambar-Blue";
      ref = "Ambar-Blue";
      rev = "65bde516ab9ce94e9822d058eb46295b0903103b";
    })
    # Sweet-Ambar
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Ambar";
      ref = "Ambar";
      rev = "13d170fa24d65477ca6d37dbdda246b3d2a91340";
    })
    # Sweet-Mars
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-mars";
      ref = "mars";
      rev = "e92731b6c516e5419c736c0ea3092f98f2162801";
    })
    # Sweet-Nova (AKA Sweet-Dark)
    (fetchGit {
      url = "https://github.com/EliverLara/Sweet.git";
      name = "Sweet-Dark";
      ref = "nova";
      rev = "b84aa671703b076743091ed37453602c6d4b4be7";
    })
  ];

  sourceRoot = ".";

  installPhase = ''
    # Plasma components
    # Aurorae window border theme
    mkdir -p $out/share/aurorae
    mv Sweet-Dark/kde/aurorae $out/share/aurorae/themes

    # Plasma color scheme
    mv Sweet-Dark/kde/colorschemes $out/share/color-schemes

    # Konsole color scheme
    mv Sweet-Dark/kde/konsole $out/share/konsole

    # Kvantum themes (do not appear to work; will have to install in ~/.convig/Kvantum)
    # Inside main /usr/share/themes/X folder
    #mkdir Sweet-Dark/Kvantum
    #cp Sweet-Dark/kde/kvantum/Sweet-transparent-toolbar.kvconfig Sweet-Dark/Kvantum/Sweet-Dark.kvconfig
    #cp Sweet-Dark/kde/kvantum/Sweet.svg Sweet-Dark/Kvantum/Sweet-Dark.svg
    # Standalone /usr/share/Kvantum
    #mkdir -p $out/share/Kvantum/Sweet-transparent-toolbar
    #mv Sweet-Dark/kde/kvantum/Sweet-transparent-toolbar.kvconfig $out/share/Kvantum/Sweet-transparent-toolbar/
    #cp Sweet-Dark/kde/kvantum/Sweet.svg $out/share/Kvantum/Sweet-transparent-toolbar/Sweet-transparent-toolbar.svg
    #mv Sweet-Dark/kde/kvantum $out/share/Kvantum/Sweet

    # Look-and-feel theme
    mkdir -p $out/share/plasma/look-and-feel
    mv Sweet-Dark/kde/look-and-feel $out/share/plasma/look-and-feel/Sweet

    # SDDM login screen theme
    #mkdir -p $out/share/sddm/themes
    #mv Sweet-Dark/kde/sddm $out/share/sddm/themes/Sweet

    # The standard Sweet GTK themes
    mkdir $out/share/themes
    mv Sweet* $out/share/themes/
  '';

  meta = with stdenv.lib; {
    description = "Light and dark colorful Gtk3.20+ theme.";
    homepage = https://github.com/EliverLara/Sweet;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
