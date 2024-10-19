{ pkgs, ... }:
{
  home.username = "nikita";
  home.homeDirectory = "/home/nikita";
  home.stateVersion = "24.05"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;

  home.file.".config/i3status/config".source = ./i3status.conf;

  home.packages =
    with pkgs;
    [
    ];
}
