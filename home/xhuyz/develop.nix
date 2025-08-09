{
  imports = [
    ../common
    ../features/
    ../features/packages/
  ];

  features = {
    programs = {
      kitty.enable = true;
      nushell.enable = true;
      starship.enable = true;
      lazysql.enable = true;
    };
  };
}

