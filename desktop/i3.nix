{ config, pkgs, lib, ... }: {
  home.pointerCursor = {
    package = pkgs.breeze-cursor;
    name = "Breeze";
    gtk.enable = true;
    x11.enable = true;
  };

  services.betterlockscreen = {
    enable = true;
    inactiveInterval = 10; # auto locks
  };

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      # disable generation of default config
      config = null;
      extraConfig = lib.strings.fileContents ./i3.config;
    };
  };
}
