{pkgs, ...}: {
  imports = [
  ./kitty/default.nix
  ./nushell/default.nix
  ./starship/default.nix
  ./lazysql/default.nix
  # ./nixvim/default.nix
  ];
}

