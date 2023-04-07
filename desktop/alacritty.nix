{ config, pkgs, lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
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
        {
          # clear terminal
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      font = let fontname = "FiraCode Nerd Font Mono"; in
        {
          normal = { family = fontname; style = "Bold"; };
          bold = { family = fontname; style = "Bold"; };
          italic = { family = fontname; style = "Light"; };
          size = 14;
        };
      cursor.style = "Block";

      colors = {
        primary = {
          background = "0x1a1b26";
          foreground = "0xc0caf5";
        };
        normal = {
          black = "0x15161e";
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
