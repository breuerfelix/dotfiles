{ ... }: {
  services.skhd = {
    enable = false;
    skhdConfig = ''
      # alt + a / u / o / s are blocked due to umlaute

      # focus window
      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east

      # focus window in stacked
      alt - j : if [ "$(yabai -m query --spaces --space | jq -r '.type')" = "stack" ]; then yabai -m window --focus stack.next || yabai -m window --focus stack.first; else yabai -m window --focus south; fi
      alt - v : if [ "$(yabai -m query --spaces --space | jq -r '.type')" = "stack" ]; then yabai -m window --focus stack.next || yabai -m window --focus stack.first; else yabai -m window --focus south; fi

      alt - k : if [ "$(yabai -m query --spaces --space | jq -r '.type')" = "stack" ]; then yabai -m window --focus stack.prev || yabai -m window --focus stack.last; else yabai -m window --focus north; fi
      alt - c : if [ "$(yabai -m query --spaces --space | jq -r '.type')" = "stack" ]; then yabai -m window --focus stack.prev || yabai -m window --focus stack.last; else yabai -m window --focus north; fi

      # swap managed window
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      # toggle layout
      alt - d : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "stack" else "bsp" end')
    '';
  };
}
