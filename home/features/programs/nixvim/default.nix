{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.features.programs.nixvim;
in {
  options.features.programs.nixvim.enable =
    lib.mkEnableOption "Enable NixVim configuration";
    
  config = lib.mkIf cfg.enable {
  home.packages = [ 
      pkgs.my-neovim
    ];
  };
}
