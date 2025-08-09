{
  imports = [
    ../common
    ../features/programs
    ../features/packages
    ../features/wm
    ./home.nix
  ];

  features = {
    programs = {
      nushell.enable = true;
      starship.enable = true;
      # kitty.enable = true;
      # lazysql.enable = true;
      # libreoffice-fresh.enable = true;
    };
  };
}

