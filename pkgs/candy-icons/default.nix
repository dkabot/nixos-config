{ stdenv, fetchFromGitHub, gtk3 }:

stdenv.mkDerivation rec {
  pname = "candy-icons";
  version = "798e662";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = pname;
    rev = version;
    sha256 = "0hd8s3bjprx34fw6464vihn8n48rybyy82ah93b6g18zvq35vmgi";
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
