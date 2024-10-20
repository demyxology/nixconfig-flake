{ pkgs }:
{
  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.gvfs = {
    enable = true;
    package = pkgs.gnome3.gvfs;
  };
}
