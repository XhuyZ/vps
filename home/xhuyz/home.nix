{ config, lib, pkgs, ... }:
{
  home.username = lib.mkDefault "xhuyz";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "25.05"; 
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
    imports = [
    ./programs/kitty/kitty.nix
    ./programs/git.nix
    ./programs/nushell/nushell.nix
    ./packages/default.nix
  ];
  programs.home-manager.enable = true;
}

