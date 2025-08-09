{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.starship;
in {
  options.features.programs.starship.enable = mkEnableOption "enable starship prompt";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };
}


