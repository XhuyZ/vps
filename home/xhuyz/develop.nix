{ config, pkgs, lib, inputs, outputs,nixvim , ... }:
{
  imports = [
    ../common
    ../features/programs
    ../features/packages
    ../features/wm
    ./home.nix
  ];
  programs.nixvim.enable = true;
  features = {
    programs = {
      nushell.enable = true;
      starship.enable = true;
      kitty.enable = true;
      nixvim.enable = true;
    };
    wm = {
      office.enable = true;
      blender.enable = true;
      kdenlive.enable = true;
      dbeaver.enable = true;
      obs.enable = true;
    };
  };
}

