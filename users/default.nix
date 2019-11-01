# User account configurations for all systems.

{ config, lib, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "6b6f759e7a3235027a0b38b724ed4fb9480bf608";
    #ref = "release-20.03";
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
  # lib.mkIf seems to require entire blocks to work, so this is the best method I know of offhand.
  users.users.root.hashedPassword = (if builtins.pathExists ./root.hashedPassword
   then readHashedPassword ./root.hashedPassword
   else null);

}
