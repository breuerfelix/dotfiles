{ config, pkgs, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./user.nix
    ./dunst.nix
    ./i3.nix
    ./xdg.nix
    ./polybar.nix
  ];

  home.sessionVariables.GTK_THEME = "Generated";
  gtk = {
    enable = true;

    font = {
      name = "Source Sans Pro 10";
      package = pkgs.source-sans-pro;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Generated";
      package = pkgs.generated-gtk-theme;
    };
  };

  programs = {
    obs-studio.enable = true;

    rofi = {
      enable = true;
      cycle = true;
      font = "FuraMono Nerd Font Mono 12";

      # TODO generate theme
      theme = ./rofi.rasi;
      extraConfig = {
        kb-remove-to-eol = "";
        kb-accept-entry = "Return";
        kb-row-up = "Control+k";
        kb-row-down = "Control+j";
      };
    };

    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
  };

  services = {
    flameshot.enable = true;
    picom = {
      enable = true;
      # turn off vsync because of stuttering in obs
      vSync = false;
      backend = "glx";
      #shadow = true;
      #noDNDShadow = false;
      #noDockShadow = true;
      #shadowExclude = [ "class_g = 'i3-frame'" ];
    };

    redshift = {
      enable = true;
      tray = true;
      # germany -> kölle
      latitude = "50.935173";
      longitude = "6.953101";
      settings.redshift = {
        brightness-day = "1";
        brightness-night = "0.8";
      };
      temperature = {
        night = 3700;
        day = 5500;
      };
    };
  };
}
