{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.features.programs.nixvim;
in {
  options.features.programs.nixvim.enable =
    mkEnableOption "Enable NixVim configuration";

  config = mkIf cfg.enable {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim

      ./plugins/default.nix
      ./lsp/conform.nix
      ./lsp/fidget.nix
      ./lsp/lsp.nix
      ./lsp/roslyn.nix
    ];

    programs.nixvim = {
      enable = true;
    };
  };
}

