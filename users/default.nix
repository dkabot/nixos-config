# User account configurations for all systems.

{ config, lib, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    rev = "684e85d01d333be91c4875baebb05b93c7d2ffaa";
    #ref = "release-21.11";
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
