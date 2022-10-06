{ config, pkgs, lib, ... }: {
  nix = {
    settings.auto-optimise-store = true;
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

  i18n = let locale = "en_US.UTF-8"; in
    {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ALL = locale;
        LANG = locale;
      };
    };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment = {
    systemPackages = with pkgs; [
      htop
      curl
      git
      neovim
      nvtop # gpu monitor
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

  # enables realtime processing
  security.rtkit.enable = true;

  hardware.pulseaudio.enable = false; # use pipewire instead
  sound.enable = true;
  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # no other session manager are available right now
      media-session.enable = true;
    };

    xserver = {
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

      # home-manager handles xsession
      desktopManager = {
        # wallpaper at ~./background-image will be used
        wallpaper.mode = "fill";
        session = [{
          name = "xsession";
          start = ''
            ${pkgs.runtimeShell} $HOME/.xsession &
            waitPID=$!
          '';
        }];
      };

      displayManager = {
        gdm.enable = true;
        # enable if error when unlocking keyring
        #sessionCommands = ''
        #${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        #'';
      };
    };
  };
}
