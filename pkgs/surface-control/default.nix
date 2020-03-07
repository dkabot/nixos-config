{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "surface-control";
  version = "0.2.5-2";

  src = fetchFromGitHub {
    owner = "linux-surface";
    repo = "surface-control";
    rev = "f8df274deaac59fbadc70da0bc5beb9c6b3f17b9";
    sha256 = "155wricmigyyiw03lng5xpvisxgcf9sq8wmg31009bjqba114y3l";
  };

  cargoSha256 = "11g9zck4prjh86a5kvgiwac2pavwk2by45glw4kr2qfxiyazswa5";

  meta = with lib; {
    description = "Control various aspects of Microsoft Surface devices on Linux from the Command-Line.";
    homepage = https://github.com/linux-surface/surface-control;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
