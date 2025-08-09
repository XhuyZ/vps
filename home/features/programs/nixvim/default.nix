{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.features.programs.nixvim;
in {
  options.features.programs.nixvim.enable =
    mkEnableOption "Enable NixVim configuration";

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      imports = [
      ./plugins/default.nix
      ./lsp/conform.nix
      ./lsp/fidget.nix
      ./lsp/lsp.nix
      ./lsp/roslyn.nix
      ];
    };
  };
}

