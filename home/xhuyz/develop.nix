{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    ./home.nix
    ../common/default.nix
  ];

  home.username = "xhuyz";
  home.homeDirectory = "/home/xhuyz";
}

