{
  description = ''
  XhuyZ
  '';
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    disko.url = "github:nix-community/disko";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim.url = "github:nix-community/nixvim";
    my-nixvim.url = "github:XhuyZ/nixvim";
  };
  outputs = { self, home-manager, nixpkgs, nixos-hardware, nixvim, my-nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./hosts/overlays { inherit inputs; };
      nixosConfigurations = {
        develop = nixpkgs.lib.nixosSystem {    
            system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ 
          ./hosts/develop 
          inputs.disko.nixosModules.disko
          nixos-hardware.nixosModules.asus-fx506hm
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.sharedModules = [
            nixvim.homeModules.nixvim
            ];
          }
          ];
        };
      };
      homeConfigurations = {
        "xhuyz@develop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            ./home/xhuyz/develop.nix
          ];
        };
      };
    };
}
