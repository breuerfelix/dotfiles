{ config, pkgs, lib, ... }: {
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowPing = false;
    };

    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_US.utf8";
      LANG = "en_US.utf8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment = {
    # completion for zsh
    #pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      htop
      curl
      git
      neovim
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # only nixos specific aliases here
    shellAliases = {
      nsh = "nix-shell";
    };
  };

  sound.enable = true;

  #services.blueman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  #hardware = {
  #bluetooth.enable = true;
  #pulseaudio = {
  #enable = true;
  ## use full build for bluetooth support
  #package = pkgs.pulseaudioFull;
  #extraModules = [ pkgs.pulseaudio-modules-bt ];
  #daemon.config = {
  ## this fixes audio stuttering
  ## when using bluetooth headset + bluetooth mouse at the same time
  #default-sample-rate = 48000;
  #default-fragments = 8;
  #default-fragment-size-msec = 10;
  ## TODO check if those values are also needed for this fix
  ## source: https://forums.linuxmint.com/viewtopic.php?t=44862
  #high-priority = "yes";
  #nice-level = -15;
  #realtime-scheduling = "yes";
  #realtime-priority = 1;
  #};
  #};
  #};

  services.xserver = {
    enable = true;

    layout = "eu";
    # replaces capslock with control
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "";

    # resolution of UI elements
    #dpi = 115;

    # keyboard repeat time
    autoRepeatInterval = 35;
    autoRepeatDelay = 320;

    # used to let home-manager handle xsession
    desktopManager = {
      #xterm.enable = false;
      # wallpaper at ~./background-image will be used
      #wallpaper.mode = "fill";
      session = [{
        name = "xsession";
        start = ''
          ${pkgs.runtimeShell} $HOME/.xsession &
          waitPID=$!
        '';
      }];
      #xfce.enable = true;
    };
    # automatically logs in my user
    # enables logging out manually
    displayManager = {
      # enable if error when unlocking keyring
      #sessionCommands = ''
      #${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
      #'';
      autoLogin = {
        enable = false;
        user = "felix";
      };

      lightdm.enable = true;
    };
  };
}
