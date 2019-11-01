{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "linux-surface-control";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "qzed";
    repo = "linux-surface-control";
    rev = "639e889aa2a47f8c1dc1c1eb7ed339a72231117c";
    sha256 = "1z2d8dvai5aqxqdhd8kf7gfyaalmdjhs57mn2l911kw52fjp25i5";
  };

  cargoSha256 = "0g0xvrjw4hwsnbvzqpkn3hhczlp5r2dzx1cqj9z2c8sz3r07ap0q";

  meta = with lib; {
    description = "Control various aspects of Microsoft Surface devices on Linux from the Command-Line.";
    homepage = https://github.com/qzed/linux-surface-control;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
