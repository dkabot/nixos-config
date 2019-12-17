# Applies HiDPI console font for readability.

{ config, pkgs, ... }:

{
  # Font is ter-132b
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";

  # Apply font as soon as possible, for LUKS etc.
  console.earlySetup = true;
}
