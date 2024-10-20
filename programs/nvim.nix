{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        set tabstop=2
        set shiftwidth=2
        set smartcase
      '';
    };
  };
}
