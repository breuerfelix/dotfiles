{ config, pkgs, lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        opacity = 1;
        dynamic_title = true;
        dynamic_padding = true;
        decorations = "full";
        dimensions = { lines = 0; columns = 0; };
        padding = { x = 5; y = 5; };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      mouse = { hide_when_typing = true; };

      key_bindings = [
        { # clear terminal
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      font = let fontname = "SauceCodePro Nerd Font Mono"; in {
      #font = let fontname = "Recursive Mono Linear"; in { # TODO fix this font with nerd font
        normal = { family = fontname; style = "Medium"; };
        bold = { family = fontname; style = "Bold"; };
        italic = { family = fontname; style = "Light"; };
        size = 16;
      };
      cursor.style = "Block";

      colors = {
        primary = {
          background = "0x24283b";
          foreground = "0xc0caf5";
        };
        normal = {
          black = "0x1D202F";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xbb9af7";
          cyan = "0x7dcfff";
          white = "0xa9b1d6";
        };
        bright = {
          black = "0x414868";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xbb9af7";
          cyan = "0x7dcfff";
          white = "0xc0caf5";
        };
        indexed_colors = [
          { index = 16; color = "0xff9e64"; }
          { index = 17; color = "0xdb4b4b"; }
        ];
      };
    };
  };
}
