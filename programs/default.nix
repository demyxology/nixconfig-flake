{ pkgs, lib }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    cachix
    chafa
    cifs-utils
    dconf
    dex
    emacs
    fd
    file
    fzf
    git
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
    wget
    xclip
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    xfce.xfwm4-themes
    zoxide
    zsh
    nixfmt-rfc-style
    retroarch
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Misc tbh
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "google-chrome"
      "vscode"
      "libretro-snes9x"
    ];
}
