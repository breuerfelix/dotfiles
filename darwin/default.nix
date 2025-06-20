{ pkgs, ... }: {
  imports = [ ./homebrew.nix ./skhd.nix ./yabai.nix ];

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    # is needed for shell integrations to work
    # most of them fail if zsh is only enabled via hm
    zsh.enable = true;
    nix-index.enable = true;
  };

  services = {
    # FIXME: driver issues
    karabiner-elements.enable = false;
    sketchybar = {
      enable = false;
      extraPackages = with pkgs; [ jq gh ];
    };
  };

  networking = {
    knownNetworkServices = [ "Wi-Fi" "Thunderbolt Bridge" ];
    dns = [ "192.168.178.12" "9.9.9.9" "1.1.1.1" "8.8.8.8" ];
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      sketchybar-app-font
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 4.0;
      spaces.spans-displays = false;
      universalaccess = {
        # FIXME: cannot write universal access
        #reduceMotion = true;
        #reduceTransparency = true;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "bottom";
        dashboard-in-overlay = true;
        largesize = 85;
        tilesize = 50;
        magnification = true;
        launchanim = false;
        mru-spaces = false;
        show-recents = false;
        show-process-indicators = false;
        static-only = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # current folder
        QuitMenuItem = true;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = 2.0;
      };
    };
  };
}
