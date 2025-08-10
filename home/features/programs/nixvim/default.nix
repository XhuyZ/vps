{ config, pkgs, inputs, lib, ... }:
let
  cfg = config.features.programs.nixvim;
in {
  imports = [
    inputs.nixvim.homeModules.my-nixvim
  ];

  options.features.programs.nixvim.enable =
    lib.mkEnableOption "Enable NixVim configuration";

  config = lib.mkIf cfg.enable {
    programs.nixvim.enable = true;
  };
}

