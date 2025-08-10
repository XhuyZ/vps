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
        description = "Neovim configured with nixvim";
        longDescription = "Custom Neovim configuration built with nixvim";
        homepage = "https://github.com/XhuyZ/nixvim";
        license = final.lib.licenses.mit;
        maintainers = [ ];
        platforms = final.lib.platforms.unix;
      };
    });
  };table-packages = final: _prev: {
    stable = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

