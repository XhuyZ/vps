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
      meta = (old.meta or {}) // {
        description = (old.meta.description or "Neovim text editor (custom nixvim build)");
        longDescription = (old.meta.longDescription or "Neovim is a hyperextensible Vim-based text editor with custom configuration.");
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

