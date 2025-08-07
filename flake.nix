{
  description = ''
    XhuyZ
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, disko, nixos-hardware, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system:
        import ./pkgs nixpkgs.legacyPackages.${system}
      );

      overlays = import ./hosts/overlays { inherit inputs; };

      nixosConfigurations = {
        develop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/develop
            inputs.disko.nixosModules.disko
            nixos-hardware.nixosModules.asus-fx506hm
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.xhuyz = import ./home/xhuyz/develop.nix {
                inherit inputs outputs;
              };
            }
          ];
        };
      };
    };
}

