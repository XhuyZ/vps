{pkgs, ...}: {
  imports = [
  ./kitty/default.nix
  ./nushell/default.nix
  ./starship/default.nix
  ./lazysql/default.nix
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };
}

