{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.wm.office;
in {
  options.features.wm.office.enable =
    mkEnableOption "install office and paperwork stuff";

  config = mkIf cfg.enable {
    programs.neovim.enable = true;
    home.packages = with pkgs; [
    libreoffice-fresh
    ];
  };
}

