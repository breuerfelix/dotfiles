{ config, pkgs, lib, ... }: {
  environment = {
    systemPackages = with pkgs; [ ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    zsh.enable = true;
  };

  networking = {
    knownNetworkServices = [ "Wi-Fi" ];
    dns = [
      "9.9.9.9"
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  security = {
    pam.enableSudoTouchIdAuth = true;
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      NSGlobalDomain = {
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        # FIXME: find suitable values
        #InitialKeyRepeat = 2;
        #KeyRepeat = 1;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.0;
        _HIHideMenuBar = true;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = 3.0;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "bottom";
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # current folder
        QuitMenuItem = true;
      };

      spaces.spans-displays = false;
    };
  };
}
