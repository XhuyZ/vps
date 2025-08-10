{ inputs, ... }: {
  # Bring custom packages from pkgs directory
  additions = final: _prev: import ../../pkgs { pkgs = final; };

  # Overlay for modifications to existing packages
  modifications = final: prev: {
    # Example modification:
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    #   ...
    # });
  };
 nixvim-overlay = final: prev: {
    my-nixvim = inputs.my-nixvim.packages.${prev.system}.default.overrideAttrs (oldAttrs: {
      meta = (oldAttrs.meta or {}) // {
        available = true;
        broken = false;
        changelog = "https://github.com/XhuyZ/nixvim";
        description = "Neovim configured with nixvim";
        homepage = "https://github.com/XhuyZ/nixvim";
        insecure = false;
        license = final.lib.licenses.mit;
        longDescription = "Custom Neovim configuration built with nixvim";
        mainProgram = "nvim";
        maintainers = [ ];
        name = "nixvim-xhuyz";
        outputsToInstall = [ "out" ];
        platforms = final.lib.platforms.unix;
        position = null;
        teams = [ ];
        teamsPosition = null;
        unfree = false;
        unsupported = false;
      };
    });
  }; table-packages = final: _prev: {
    stable = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

