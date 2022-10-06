{ config, pkgs, lib, ... }: {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let browsers = [ "firefox.desktop" "chromium.desktop" ]; in
        {
          "text/uri-list" = browsers;
          "text/html" = browsers;
          "x-scheme-handler/http" = browsers;
          "x-scheme-handler/https" = browsers;
          "x-scheme-handler/about" = browsers;
          "x-scheme-handler/unknown" = browsers;
          "x-scheme-handler/discord" = [ "discord.desktop" ];
          "application/pdf" = browsers;
        };
    };
  };
}
