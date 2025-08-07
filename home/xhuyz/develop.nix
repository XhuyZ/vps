{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    ./home.nix
    ../common/
  ];

  home.username = "xhuyz";
  home.homeDirectory = "/home/xhuyz";
}

