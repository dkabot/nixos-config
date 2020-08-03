{ stdenv, fetchFromGitHub, gtk3 }:

stdenv.mkDerivation rec {
  pname = "sweet-folders";
  version = "d50fbe3d93df4c494958c773b681ab36049935a1";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Sweet-folders";
    rev = version;
    sha256 = "0qk41ga323qfrkjw0qmsq04s974wnar91yf6chj4w9m2x88k0c6w";
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
