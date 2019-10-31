{ stdenv, fetchFromGitHub, gtk3 }:

stdenv.mkDerivation rec {
  pname = "candy-icons";
  version = "d0a49f869ee212489154c000c754166c14ad83f3";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = pname;
    rev = version;
    sha256 = "0xm4md49pqkmmalrpmh95x0p980g8p0cn74dzmsalz7ghdymyx98";
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

  meta = with stdenv.lib; {
    description = "Sweet gradient icons.";
    homepage = https://github.com/EliverLara/candy-icons;
    platforms = platforms.linux;
  };
}
