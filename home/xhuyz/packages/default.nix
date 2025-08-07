{ pkgs, ... }:
{
  home.packages = [
    pkgs.neofetch
    pkgs.fastfetch
    pkgs.pfetch
    pkgs.htop
    pkgs.btop
    pkgs.neovim
    pkgs.git
    pkgs.vim
    pkgs.cava
    pkgs.cmatrix
    pkgs.fzf
    pkgs.nushell
    pkgs.libgcc
    pkgs.tree
    pkgs.zig_0_12
    pkgs.starship
    pkgs.lazysql
  ];
}

