{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.wm.office;
in {
  options.features.desktop.wm.enable =
    mkEnableOption "install office and paperwork stuff";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
    ];
  };
}

