# 'naomi' account configuration.

{ config, lib, ... }:

let
  readHashedPassword = file:
    lib.fileContents file;

in

{
  imports = [
    # Apply home configuration.
    ./home.nix
  ];

  # Define account.
  users.users.naomi = {
    description = "Naomi Morse";
    isNormalUser = true;
    home = "/home/naomi";
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    hashedPassword = readHashedPassword ./naomi.hashedPassword;

  };

}
