{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "chicago95-theme";
  version = "05fb412";

  src = fetchFromGitHub {
    owner = "grassmunk";
    repo = "Chicago95";
    rev = version;
    sha256 = "1lfmnbq2qavm3pv8qrn7p5zj96x51g7plgf5dn25z47sd1r36amy";
  };

  installPhase = ''
    # Main theme
    mkdir -p $out/share/themes
    cp -r Theme/Chicago95 $out/share/themes/
    # Icon themes
    mkdir -p $out/share/icons
    cp -r Icons/* $out/share/icons/
    # Plymouth themes
    mkdir -p $out/share/plymouth/themes
    cp -r Plymouth/Chicago95 $out/share/plymouth/themes/
    cp -r Plymouth/RetroTux $out/share/plymouth/themes/
    # LightDM theme ommitted due to lack of lightdm-webkit2-greeter
    # SDDM theme
    mkdir -p $out/share/sddm/themes
    tar -C $out/share/sddm/themes/ -xzf KDE/SDDM/Chicago95.tar.gz
  '';

  meta = with stdenv.lib; {
    description = "Windows 95-based themes.";
    homepage = https://github.com/grassmunk/Chicago95;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
