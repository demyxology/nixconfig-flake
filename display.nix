{ pkgs }:
{
  services = {
    xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          rofi
        ];
        configFile = ./i3.conf;
      };
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager.lightdm.greeters.slick = {
        enable = true;
        draw-user-backgrounds = true;
      };
    };
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
    };
  };

  # Compositor i.e. window effects
  services.picom = {
    enable = true;
    backend = "egl";
    vSync = true;
    fade = true;
    fadeDelta = 2;
    settings = {
      blur-method = "gaussian";
      blur-size = 15;
      blur-strength = 15;
      blur-background-frame = true;
      blur-kern = "3x3box";
      dbus = true;
      use-ewmh-active-win = true;
      detect-transient = true;
      use-damage = true;

      corner-radius = 10;
      # Not sure if intentional, but transparency doesn't work at all
      # unless it's first set here and then overwritten by the app
      opacity-rule = [
        "100:class_g = 'i3status'"
        "100:class_g = 'kitty'"
      ];
      focus-exclude = "x = 0 && y = 0 && override_redirect = true";
    };
  };

  services.displayManager.defaultSession = "xfce+i3";
}
