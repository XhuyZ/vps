{
  imports = [
    ../common
    ../features/programs
    ../features/packages
    ../features/wm
    ./home.nix
  ];
  nixpkgs.overlays = [
    outputs.overlays.nixvim-overlay
  ];

  features = {
    programs = {
      nushell.enable = true;
      starship.enable = true;
      kitty.enable = true;
      nixvim.enable = true;
    };
    wm = {
      office.enable = true;
    };
  };

}

