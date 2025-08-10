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
    my-neovim = inputs.my-nixvim.packages.${prev.system}.default;
  };

  # Stable package set
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

