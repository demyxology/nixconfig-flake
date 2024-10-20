{ pkgs }:
{
  # Default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableLsColors = true;
    shellInit = "eval \"$(zoxide init zsh --cmd cd)\"";

    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/nixconfig-flake/ --max-jobs 2 --cores 1";
      e = "nvim";
      econf = "nvim ~/nixconfig-flake/configuration.nix";
      eflake = "nvim ~/nixconfig-flake/flake.nix";
      ekitty = "e ~/.config/kitty/kitty.conf";
      ei3 = "e ~/nixconfig-flake/i3.conf";
      epicom = "econf";
      se = "sudo -E nvim";
    };

    ohMyZsh = {
      enable = true;
      theme = "clean";
      plugins = [
        "bgnotify"
        "history-substring-search"
        "thefuck"
      ];
    };
  };
}
