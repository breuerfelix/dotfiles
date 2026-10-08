{ config, ... }:
let
  font = config.programs.alacritty.settings.font;
in {
  xdg.configFile."ghostty/config".force = true;

  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-family = font.normal.family;
      font-family-bold = font.bold.family;
      font-family-italic = font.italic.family;
      font-style = font.normal.style;
      font-style-bold = font.bold.style;
      font-style-italic = font.italic.style;
      font-size = font.size;
    };
  };
}
