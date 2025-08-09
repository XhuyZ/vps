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
      kitty.enable = true;
      nushell.enable = true;
      starship.enable = true;
      lazysql.enable = true;
      libreoffice-fresh.enable = true;
    };
  };
}

