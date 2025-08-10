{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.programs.neovim;
in {
  options.features.programs.neovim.enable = mkEnableOption "enable Neovim";

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
    };
  };
}



