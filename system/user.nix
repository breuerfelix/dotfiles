{ config, pkgs, user, ... }: {
  security.sudo.wheelNeedsPassword = false;

  programs = {
    dconf.enable = true; # database for gtk applications
    nm-applet.enable = true; # networkmanager tray icon
    noisetorch.enable = true; # noise cancelling
    wireshark.enable = true; # network sniffer
    adb.enable = false; # access phone via usb
    zsh.enable = true; # picks up shell alises
  };

  services = {
    # integrated into rofi
    greenclip.enable = true;
    teamviewer.enable = true;
    # TODO setup on mac
    synergy = {
      server = {
        enable = false;
        # TODO create this file
        #configFile = "/etc/nixos/desktop/synergy.conf";
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  users.users.${user} = {
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
      "audio"
      "dialout"
      "wireshark" # network sniffer
      "podman" # allows connection to docker socket
      "adbusers" # usb debugging
      "video" # change backlight
    ];
  };
}

