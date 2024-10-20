{ pkgs }:
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    cachix
    chafa
    cifs-utils
    dconf
    dex
    discord
    emacs
    fd
    file
    fzf
    git
    google-chrome
    gvfs
    kitty
    lazygit
    libdrm
    libinput-gestures
    libuv
    libva-utils
    neovim
    oreo-cursors-plus
    vimPlugins.coq_nvim
    vimPlugins.mason-lspconfig-nvim
    vimPlugins.nvim-dap
    vimPlugins.neoconf-nvim
    vimPlugins.null-ls-nvim
    vimPlugins.omnisharp-extended-lsp-nvim
    picom
    polkit
    pulseaudioFull
    ripgrep
    thefuck
    tree-sitter
    unzip
    viu
    vscode
    wget
    xclip
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    xfce.xfwm4-themes
    zoxide
    zsh
    nixfmt-rfc-style
    (retroarch.override {
      cores = with libretro; [
        snes9x
      ];
    })
  ];
}
