# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # <nixos-hardware/lenovo/thinkpad/x220>
      ./hardware-configuration.nix
      # <home-manager/nixos>
      # inputs.home-manager.nixosModules.default

    ];

  /*
 nix = {
  package = pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
};
*/ 

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  home-manager = {
		users.nikita = { pkgs, ... }: {
			home.packages = [ ];
			programs.zsh.enable = true;

			# The state version is required and should stay at the version you
			# originally installed.
			home.stateVersion = "24.05";
		};

		useUserPackages = true;
		useGlobalPkgs = true;
	};


  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  nix.settings.experimental-features = "nix-command flakes";

  sound.enable = true;

  /*
# i3 config
  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
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
      displayManager = {
        lightdm.enable = true;
        defaultSession = "xfce+i3";
      };
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
*/ 

  programs = {
    hyprland = {
      enable = true; # enable Hyprland
      xwayland = {
        enable = true;
     };
     };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
     thunar = {
       enable = true;
       plugins = with pkgs.xfce; [
         thunar-archive-plugin
         thunar-volman
       ]; 
    };
  };
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    }; 
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
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # System
    pulseaudioFull
    home-manager
    libinput
    libinput-gestures
    xfce.thunar
    xfce.thunar-volman
    gvfs
    cifs-utils
    kitty
    polkit
    xdg-desktop-portal-hyprland
    xwayland
    wl-clipboard
    hyprland-protocols
    hyprlang
    hyprutils
    hyprwayland-scanner
    libdrm
    sdbus-cpp
    wayland-protocols
    wofi
    wofi-emoji
    waybar
    zsh

    # Dev tools
    llvm_18
    clang-tools
    clang_18


    # CLI
    # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vim
    wget
    git
    unzip
    binutils


    # GUI
    chromium
    (retroarch.override {
    cores = with libretro; [
      snes9x
    ];
    })

    # Ugh
    libva-utils
    swaynotificationcenter
    wlr-randr
    ydotool
    wl-clipboard
    hyprpicker
    swayidle
    swaylock
    xdg-desktop-portal-hyprland
    hyprpaper
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  xdg = {
  autostart.enable = true;
  portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };
};

 services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
      videoDrivers = [ "intel" ];
      libinput.enable = true;
      displayManager.gdm = {
	enable = true;
	wayland = true;
      };
    };
    dbus.enable = true;
    tumbler.enable = true;
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
  };

  security = {
    pam.services.swaylock = {
     text = ''
       auth include login
       '';
    };
    polkit.enable = true;
    rtkit.enable = true;
  };

  # programs.steam.enable = true;

  services.gvfs = {
    enable = true;
    package = pkgs.gnome3.gvfs;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    stdenv.cc.cc
  ];

  # Window manager
  # Security was enabled for SWAY
	# security.polkit.enable = true;
  #programs.light.enable = true;

  # Fonts
    fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    #initExtra = "eval \"$(zoxide init zsh --cmd cd)\"";

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      e = "nvim";
      econf = "sudo -E nvim /etc/nixos/configuration.nix";
      ehome = "e ~/.config/home-manager/home.nix";
      ezsh  = "e ~/.zshrc" ;
      resource  = "source ~/.zshrc";
      se    = "sudo -E nvim";
      hms   = "home-manager switch";
    };
    oh-my-zsh = {
      enable = true;
      theme = "clean";
    };
  };


  # Hardware (opengl, bluetooth, etc...)
  hardware = {
    opengl.enable = true;
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
