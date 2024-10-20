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
        support32Bit = true;
      };
    };
  };

  nixpkgs.config.pulseaudio = true;
}
