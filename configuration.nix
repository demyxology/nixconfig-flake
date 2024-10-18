# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nikita = {
    isNormalUser = true;
    description = "nikita";

    # video added for brightness control
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
  };

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  nix.settings.experimental-features = "nix-command flakes";

  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    };

# i3 config
  services = {
    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
        ];
      };
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      # displayManager = {
        # lightdm.enable = true;
      # };
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  services.displayManager.defaultSession = "xfce+i3";

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

    programs = {
    thunar.enable = true;
    dconf.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

 # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cifs-utils
    dex
    fd
    discord
    dmenu
    git
    google-chrome
    gvfs
    kitty
    libdrm
    libuv
    libva-utils
    neovim
    polkit
    pulseaudioFull
    ripgrep
    thefuck
    unzip
    wget
    xclip
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    xss-lock
    zoxide
    zsh
    (retroarch.override {
      cores = with libretro; [
        snes9x
      ];
    })
  ];

  xdg = {
  autostart.enable = true;
  portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
};

  services.gvfs = {
    enable = true;
    package = pkgs.gnome3.gvfs;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Fonts
    fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      dejavu_fonts
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

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

  programs.zsh = {
    enable = true;
    enableCompletion = true;	
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableLsColors = true;
    shellInit = "eval \"$(zoxide init zsh --cmd cd)\"";

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/nixconfig-flake/ --max-jobs 2 --cores 2";
      e = "nvim";
      econf = "nvim ~/nixconfig-flake/configuration.nix";
      se    = "sudo -E nvim";
    };
    ohMyZsh = {
      enable = true;
      theme = "clean";
      plugins = [
	"aliases"
	"alias-finder"
	"bgnotify"
	"common-aliases"
	"history-substring-search"
	"thefuck"
      ];
    };
  };


  # Hardware (opengl, bluetooth, etc...)
  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
  };

  # Default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall = { 
    enable = true;
    extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  /* 
  fileSystems."/home/nikita/netshare/balthasar/c" = {
      device = "//balthasar/c";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in 
        ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  }; 

  fileSystems."/home/nikita/netshare/balthasar/d" = {
      device = "//balthasar/d";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in 
        ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];

  }; 
*/ 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
