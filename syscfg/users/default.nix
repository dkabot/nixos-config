# User account configurations for all systems.

{ config, lib, ... }:

let
  readHashedPassword = file:
    lib.fileContents file;

in

{
  imports = [
    # Apply naomi's common home configuration.
    ../../homecfg/common/naomi/home.nix
  ];

  # Prevent user changes outside of the configuration's scope.
  users.mutableUsers = false;

  # 'naomi' account definition.
  users.users.naomi = {
    description = "Naomi Morse";
    isNormalUser = true;
    home = "/home/naomi";
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    hashedPassword = readHashedPassword ./naomi.hashedPassword;
  };

  # Apply the root password, if one is set.
  # lib.mkIf seems to require entire blocks to work, so this is the best method I know of offhand.
  users.users.root.hashedPassword = (if builtins.pathExists ./root.hashedPassword
   then readHashedPassword ./root.hashedPassword
   else null);

}
