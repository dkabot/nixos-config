# User account configurations for all systems.

{ config, lib, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "eb1b86a5ec7baf1a1ce2c277d568a8751c24a7ee";
    #ref = "release-19.09";
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
