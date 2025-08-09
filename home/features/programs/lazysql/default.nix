{
  config,
  pkgs,
  dotfiles,
  ...
}:

{
  programs.lazysql = {
    enable = true;
  };
}

