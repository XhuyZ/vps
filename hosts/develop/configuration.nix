{ config, inputs, ouputs, lib, pkgs, ... }:

{
  imports = [
    # ./hardware-configuration.nix
    ./disko-config.nix
  ];

  ## --- Flake support ---

  ## --- Bootloader (GRUB + UEFI only) ---
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ]; # tốt cho remote
    efiInstallAsRemovable = true; # đặt file ở EFI/BOOT/BOOTX64.EFI
  };
  ## --- Kernel ---
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## --- Host & Time ---
  networking.hostName = "develop";
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
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    enable = true;  
    displayManager.gdm = {
      wayland = true; 
    };
    desktopManager.gnome.enable = true; 
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  ## --- Printing ---
  # services.printing.enable = true;

  ## --- Sound (PipeWire) ---
  # services.pulseaudio.enable = false;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # jack.enable = true;
  # };
  # security.rtkit.enable = true;

#   ## --- User ---
users.users = {
  xhuyz = {
    isNormalUser = true;
    initialPassword = "<><>";
    extraGroups = [ "wheel" "networkmanager" ]; 
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };
};

  ## --- Unfree packages ---
  nixpkgs.config.allowUnfree = true;

  ## --- System packages ---
  environment.systemPackages = with pkgs; [
    neovim
    git
    neofetch
  ];

  ## --- SSH ---
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  ## --- Firewall ---
  networking.firewall.allowedTCPPorts = [ 22 ];

  ## --- Sudo config ---
  security.sudo.extraRules = [
    {
      groups = [ "sudo" ];
      commands = [ "ALL" ];
    }
  ];

  ## --- Required for upgrades ---
  system.stateVersion = "25.05";
}
