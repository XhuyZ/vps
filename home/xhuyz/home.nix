{ config, lib, pkgs, ... }:
let
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      ref = "main";
    }
  );
in
{
  imports = [
  nixvim.homeManagerModules.nixvim
  ];
  home.stateVersion = "25.05"; 
  home.file = {
  };
  home.username = lib.mkDefault "xhuyz";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";


  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}

