{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "surface-control";
  version = "0.3.1-1";

  src = fetchFromGitHub {
    owner = "linux-surface";
    repo = "surface-control";
    rev = "022cf214998063e546e84c32717d7a4a03b84e47";
    sha256 = "0wclzlix0a2naxbdg3wym7yw19p2wqpcjmkf7gn8cs00shrmzjld";
  };

  cargoSha256 = "0qi84x8zmr9rsjz4gxa2mk9ji1ci2ifvy2qdyb047jy735vjbqyb";

  meta = with lib; {
    description = "Control various aspects of Microsoft Surface devices on Linux from the Command-Line.";
    homepage = https://github.com/linux-surface/surface-control;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
