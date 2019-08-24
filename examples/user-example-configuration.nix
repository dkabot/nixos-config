{ config, pkgs, ... }:

{
  home-manager.users.username = {
    home.packages = [
      pkgs.neofetch
    ];

   programs.vim.enable = true;
    
  };
}
