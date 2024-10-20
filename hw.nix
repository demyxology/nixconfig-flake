{
  services = {
    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
    };
  };

  nixpkgs.config.pulseaudio = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    touchpad.accelStepScroll = 0.1;
  };

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
  };

}
