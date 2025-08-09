{ config, pkgs, dotfiles, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    font = {name = "CaskaydiaCove Nerd Font Mono";};
    settings = {copy_on_select = "yes";};
    extraConfig = builtins.readFile ./kitty.conf;
  };
}


