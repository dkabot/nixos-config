{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "linux-surface-control";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "qzed";
    repo = "linux-surface-control";
    rev = "d0b947fca26d9159b6e43f117aea4d090ece5519";
    sha256 = "0gb8rh7pf62pi6kws2gr7qzrag9wnj0v87qp1jqjklcs1rq5x8xn";
  };

  cargoSha256 = "0samk1vyn2dqmjagx8pbrr9grlf99k8rwbb91cpq8i0i04hwxaqx";

  meta = with lib; {
    description = "Control various aspects of Microsoft Surface devices on Linux from the Command-Line.";
    homepage = https://github.com/qzed/linux-surface-control;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
