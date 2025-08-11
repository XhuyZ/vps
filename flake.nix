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
          nixos-hardware.nixosModules.asus-fx504gd
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
          }
          ];
        };
        laptop-asus = nixpkgs.lib.nixosSystem {    
            system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ 
          ./hosts/laptop-asus
          inputs.disko.nixosModules.disko
          nixos-hardware.nixosModules.asus-fx504gd
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
          }
          ];
        };
        laptop-thinkpad = nixpkgs.lib.nixosSystem {    
            system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ 
          ./hosts/laptop-thinkpad
          inputs.disko.nixosModules.disko
          nixos-hardware.nixosModules.asus-fx504gd
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
          }
          ];
        };
      };
      homeConfigurations = {
        # Change networking.hostName option if want to change the hostname of the current system
        "xhuyz@develop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            ./home/xhuyz/develop.nix
          ];
        };
        "xhuyz@laptop-asus" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            ./home/xhuyz/laptop-asus.nix
          ];
        };
        "xhuyz@laptop-thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            ./home/xhuyz/laptop-thinkpad.nix
          ];
        };
      };
    };
}
