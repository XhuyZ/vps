{
  description = ''
    XhuyZ
  '';

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim.url = "github:nix-community/nixvim";
    my-nixvim.url = "github:XhuyZ/nixvim";
  };

  outputs = { self, home-manager, nixpkgs, nixos-hardware, nixvim, my-nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      overlays = import ./hosts/overlays { inherit inputs; };

      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [
          overlays.additions
          overlays.modifications
          overlays.nixvim-overlay
          overlays.stable-packages
        ];
        config.allowUnfree = true;
      };
    in {
      packages = forAllSystems (system: import ./pkgs (mkPkgs system));

      overlays = overlays;

      nixosConfigurations = {
        develop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          pkgs = mkPkgs "x86_64-linux";
          modules = [
            ./hosts/develop
            inputs.disko.nixosModules.disko
            nixos-hardware.nixosModules.asus-fx504gd
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        "xhuyz@develop" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            nixvim.homeModules.nixvim
            ./home/xhuyz/develop.nix
          ];
        };
      };
    };
}

