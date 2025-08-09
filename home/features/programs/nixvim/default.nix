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
      ./lsp/conform.nix
      ./lsp/fidget.nix
      ./lsp/lsp.nix
      ./lsp/roslyn.nix
      ./plugins/hlchunk.nix
      ./plugins/keymaps.nix
      ./plugins/kulala.nix
      ./plugins/lazygit.nix
      ./plugins/lualine.nix
      ./plugins/markview.nix
      ./plugins/neoscroll.nix
      ./plugins/nix-develop.nix
      ./plugins/noice.nix
      ./plugins/notify.nix
      ./plugins/smear-cursor.nix
      ./plugins/snacks.nix
      ./plugins/themes.nix
      ./plugins/timerly.nix
      ./plugins/tmux-navigator.nix
      ./plugins/toggleterm.nix
      ./plugins/treesitter.nix
      ./plugins/treesj.nix
      ./plugins/ts-comments.nix
      ./plugins/web-devicons.nix
      ./plugins/whichkey.nix
      ./plugins/wtf.nix
      ./plugins/yanky.nix
      ./plugins/yazi.nix
      ./plugins/zen-mode.nix
      ];
    };
  };
}

