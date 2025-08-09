{ config, lib, pkgs, ... }:
let
  cfg = config.features.programs.nixvim;
in {
  options.features.programs.nixvim.enable =
    lib.mkEnableOption "Enable NixVim configuration";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      imports = [
        nixvim.homeManagerModules.nixvim
        ./plugins/default.nix
        ./lsp/conform.nix
        ./lsp/fidget.nix
        ./lsp/lsp.nix
        ./lsp/roslyn.nix
      ];
    };
  };
}

