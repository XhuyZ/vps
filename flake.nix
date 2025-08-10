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
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim.url = "github:nix-community/nixvim";
    # Bạn có thể giữ my-nixvim để reference config, hoặc copy config vào local
    my-nixvim.url = "github:XhuyZ/nixvim";
  };
  outputs = { self, home-manager, nixpkgs, nixpkgs-unstable, nixos-hardware, nixvim, my-nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      system = "x86_64-linux";
      
      # Import nixvim config từ flake cũ (hoặc local file)
      nixvimConfig = import "${my-nixvim}/config"; # hoặc ./nixvim/config nếu copy local
    in {
      packages = forAllSystems (system: 
        let
          pkgs = nixpkgs.legacyPackages.${system};
          # Tạo standalone nixvim package (như flake cũ)
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = nixvimConfig;
          };
        in {
          # Expose standalone nixvim package
          nixvim = nvim;
          # Các packages khác
        } // import ./pkgs pkgs
      );
      
      # Standalone nixvim cho dev shell
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          unstablePkgs = nixpkgs-unstable.legacyPackages.${system};
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = nixvimConfig;
          };
        in {
          default = pkgs.mkShellNoCC {
            shellHook = ''
              echo Welcome to a Neovim dev environment powered by Nixvim
              PS1="Nixvim: \\w \$ "
              alias vim='nvim'
            '';
            packages = [
              nvim
              pkgs.dotnet-sdk
              pkgs.dotnet-aspnetcore
              pkgs.nodePackages_latest.nodejs
            ];
          };
        }
      );
      
      # Checks for nixvim
      checks = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = nixvimConfig;
          };
        in {
          nixvim = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "A nixvim configuration";
          };
        }
      );
      
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
            # Import nixvim config từ my-nixvim repo
            {
              programs.nixvim = import "${inputs.my-nixvim}/config";
            }
          ];
        };
      };
    };
}
