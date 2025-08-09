{
  imports = [
    ../common
    ../features/
    ../features/packages/
    ../features/wm/
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

