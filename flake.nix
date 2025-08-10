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
    # Flake nixvim config của bạn
    my-nixvim.url = "github:XhuyZ/nixvim";
  };
  outputs = { self, home-manager, nixpkgs, nixos-hardware, nixvim, my-nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      
      # Tạo overlay để import nixvim config từ my-nixvim flake
      myNixvimOverlay = final: prev: {
        # Làm cho nixvim config của bạn có sẵn như một package
        my-neovim = my-nixvim.packages.${final.system}.default;
      };
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      
      # Thêm overlay của bạn vào overlays
      overlays = import ./hosts/overlays { inherit inputs; } // {
        my-nixvim = myNixvimOverlay;
      };
      
      nixosConfigurations = {
        develop = nixpkgs.lib.nixosSystem {    
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ 
            ./hosts/develop 
            inputs.disko.nixosModules.disko
            nixos-hardware.nixosModules.asus-fx504gd
            inputs.home-manager.nixosModules.home-manager
            
            # Áp dụng overlay để my-neovim có sẵn trong pkgs
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ myNixvimOverlay ];
            })
          ];
        };
      };
      
      homeConfigurations = {
        "xhuyz@develop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            nixvim.homeModules.nixvim
            ./home/xhuyz/develop.nix
            
            # Cũng áp dụng overlay cho home-manager
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ myNixvimOverlay ];
            })
          ];
        };
      };
    };
}
