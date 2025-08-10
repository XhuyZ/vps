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

  # Overlay for nixvim with description fallback
nixvim-overlay = final: prev: {
  my-neovim = inputs.my-nixvim.packages.${prev.system}.default.overrideAttrs (old: {
    meta = old.meta or {} // {
      description = "My custom NixVim build";
      license = prev.lib.licenses.mit;
      maintainers = [ ];
      platforms = prev.lib.platforms.all;
    };
  });
};

  # Stable package set
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

