{
  config,
  pkgs,
  dotfiles,
  ...
}:

{
  programs.lazysql = {
    enable = true;
    extraConfig = builtins.readFile ./config.toml;
  };
}
