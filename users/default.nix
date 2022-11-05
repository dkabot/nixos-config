# User account configurations for all systems.

{ config, lib, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    rev = "93335810751f0404fe424e61ad58bc8e94bf8e9d";
    #ref = "release-22.11";
  };
  readHashedPassword = file:
    lib.fileContents file;

in

{
  imports = [
    # Import home-manager.
    "${home-manager}/nixos"
    # Add 'naomi' user by default.
    ./naomi
  ];

  # Prevent user changes outside of the configuration's scope.
  users.mutableUsers = false;

  # Apply the root password, if one is set.
  users.users.root.hashedPassword = lib.mkIf (builtins.pathExists ./root.hashedPassword) (readHashedPassword ./root.hashedPassword);

}
