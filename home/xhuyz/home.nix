{ config, lib, pkgs, ... }:
{
  home.stateVersion = "25.05"; 
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
    imports = [
    ./programs/kitty/kitty.nix
    ./programs/lazysql/lazysql.nix
    ./programs/git.nix
    ./programs/nushell/nushell.nix
    ./packages/default.nix
  ];
  programs.home-manager.enable = true;
}

