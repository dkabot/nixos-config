{ stdenv, fetchFromGitHub, gtk3 }:

stdenv.mkDerivation rec {
  pname = "sweet-folders";
  version = "8fe64a7";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Sweet-folders";
    rev = version;
    sha256 = "0lkh6sak24iw9zvmfbrn8axf0x9xbh6vln96icx7r2zk2sg9p4b5";
  };

  nativeBuildInputs = [ gtk3 ];

  postPatch = ''
    for theme in Sweet*; do
      substituteInPlace $theme/index.theme --replace breeze-dark Zafiro-icons
    done
  '';

  installPhase = ''
     mkdir -p $out/share/icons
     mv Sweet* $out/share/icons/
  '';

  postFixup = ''
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
  '';

  meta = with stdenv.lib; {
    description = "Folder icons from the Sweet GTK Theme for Linux desktop environments.";
    homepage = https://github.com/EliverLara/Sweet-folders;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
