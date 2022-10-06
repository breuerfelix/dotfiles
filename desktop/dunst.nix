{ config, pkgs, lib, ... }: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };

    settings = {
      global = {
        word_wrap = true;
        show_age_threshold = 60;
        idle_threshold = 120;

        padding = 8;
        horizontal_padding = 10;
        frame_width = 2;

        format = "%s %p\\n%b";
        geometry = "0x4-25+35";

        font = "Source Sans Pro 10";
      };
      urgency_low = { timeout = 10; };
      urgency_normal = { timeout = 10; };
      urgency_critical = { timeout = 0; };
    };
  };
}
