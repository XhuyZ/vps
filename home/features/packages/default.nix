{pkgs, inputs, ...}: {
  home.packages = with pkgs; [
    neofetch
    fastfetch
    pfetch
    htop
    btop
    # Bỏ neovim mặc định vì bạn sẽ dùng my-neovim
    # neovim  
    git
    vim
    cava
    cmatrix
    fzf
    nushell
    libgcc
    tree
    zig_0_12
    starship
    lazysql
    dbeaver-bin
    
    # Sử dụng nixvim config từ overlay
    my-neovim
    
    # Hoặc nếu overlay không hoạt động, dùng trực tiếp từ inputs
    # inputs.my-nixvim.packages.${pkgs.system}.default
  ];
}
