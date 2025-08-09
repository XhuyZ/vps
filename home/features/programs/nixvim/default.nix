{ config, lib, pkgs, ... }:
let
  cfg = config.features.programs.nixvim;
in {
  options.features.programs.nixvim.enable =
    lib.mkEnableOption "Enable NixVim configuration";
    
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      opts = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smartindent = true;
        wrap = false;
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
        incsearch = true;
      };
      imports = [
        ./plugins/default.nix
        ./lsp/conform.nix
        ./lsp/fidget.nix
        ./lsp/roslyn.nix
      ];
    };
  };
}
