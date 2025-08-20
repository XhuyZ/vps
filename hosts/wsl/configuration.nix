{ config, inputs, outputs, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];
  ## --- Host & Time ---
  networking.hostName = "wsl";
  time.timeZone = "Asia/Ho_Chi_Minh";
  ## --- Locale ---
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };
  ## --- Networking ---
  networking.networkmanager.enable = true;

  ## --- GUI: GNOME Desktop ---
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;


#   ## --- User ---
users.users = {
  xhuyz = {
    isNormalUser = true;
    initialPassword = "<><>";
    extraGroups = [ "wheel" "networkmanager" ]; 
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };
};
home-manager = {
  useUserPackages = true;
  extraSpecialArgs = { inherit inputs outputs; };
  users.xhuyz =
    import ../../home/xhuyz/${config.networking.hostName}.nix;
};


  ## --- Unfree packages ---
  nixpkgs.config.allowUnfree = true;

  ## --- System packages ---
  environment.systemPackages = with pkgs; [
    inputs.my-nixvim.packages.${system}.default
    git
    neofetch
  ];

  ## --- SSH ---
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  ## --- Firewall ---
  networking.firewall.allowedTCPPorts = [ 22 8080 ];

  ## --- Sudo config ---
  security.sudo.extraRules = [
    {
      groups = [ "sudo" ];
      commands = [ "ALL" ];
    }
  ];

  system.stateVersion = "25.05";
}

