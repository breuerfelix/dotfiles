{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # load scripting addition
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      # bar configuration
      yabai -m config external_bar all:0:39
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"

      # borders
      yabai -m config window_border on
      yabai -m config window_border_width 2
      yabai -m config active_window_border_color 0xFF40FF00
      yabai -m config normal_window_border_color 0x00FFFFFF
      yabai -m config insert_feedback_color 0xffd75f5f

      yabai -m config window_shadow off

      # layout
      yabai -m config layout bsp
      yabai -m config auto_balance off
      yabai -m config window_topmost on

      # gaps
      yabai -m config top_padding    0
      yabai -m config bottom_padding 0
      yabai -m config left_padding   0
      yabai -m config right_padding  0
      yabai -m config window_gap     0

      # rules
      yabai -m rule --add app="^System Preferences$" manage=off

      # workspace management
      yabai -m space 1 --label term
      yabai -m space 2 --label code
      yabai -m space 3 --label www
      yabai -m space 4 --label chat
      yabai -m space 5 --label todo
      yabai -m space 6 --label music
      yabai -m space 7 --label seven
      yabai -m space 8 --label eight
      yabai -m space 9 --label nine
      yabai -m space 10 --label ten

      # assign apps to spaces
      yabai -m rule --add app="Alacritty" space=term
      yabai-m rule --add app="Visual Studio Code" space=code
      yabai -m rule --add app="Vivaldi" space=www
      yabai -m rule --add app="Google Chrome" space=seven
      yabai -m rule --add app="Microsoft Teams" space=chat
      yabai -m rule --add app="Slack" space=chat
      yabai -m rule --add app="Signal" space=chat
      yabai -m rule --add app="Spotify" space=music
      yabai -m rule --add app="Todoist" space=todo

      echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = let yabai = "/opt/homebrew/bin/yabai"; in
      ''
        # workspaces
        ctrl + alt - j : ${yabai} -m space --focus next
        ctrl + alt - k : ${yabai} -m space --focus prev
        cmd + alt - j : ${yabai} -m space --focus next
        cmd + alt - k : ${yabai} -m space --focus prev

        # send window to space and follow focus
        ctrl + alt - l : ${yabai} -m window --space next; ${yabai} -m space --focus next
        ctrl + alt - h : ${yabai} -m window --space prev; ${yabai} -m space --focus prev
        cmd + alt - l : ${yabai} -m window --space next; ${yabai} -m space --focus next
        cmd + alt - h : ${yabai} -m window --space prev; ${yabai} -m space --focus prev

        # focus window
        alt - h : ${yabai} -m window --focus west
        alt - l : ${yabai} -m window --focus east

        # focus window in stacked
        alt - j : if [ "$(${yabai} -m query --spaces --space | jq -r '.type')" = "stack" ]; then ${yabai} -m window --focus stack.next; else ${yabai} -m window --focus south; fi
        alt - k : if [ "$(${yabai} -m query --spaces --space | jq -r '.type')" = "stack" ]; then ${yabai} -m window --focus stack.prev; else ${yabai} -m window --focus north; fi

        # swap managed window
        shift + alt - h : ${yabai} -m window --swap west
        shift + alt - j : ${yabai} -m window --swap south
        shift + alt - k : ${yabai} -m window --swap north
        shift + alt - l : ${yabai} -m window --swap east

        # increase window size
        shift + alt - a : ${yabai} -m window --resize left:-20:0
        shift + alt - s : ${yabai} -m window --resize right:-20:0

        # toggle layout
        alt - t : ${yabai} -m space --layout bsp
        alt - s : ${yabai} -m space --layout stack

        # float / unfloat window and center on screen
        alt - n : ${yabai} -m window --toggle float; \
                  ${yabai} -m window --grid 4:4:1:1:2:2

        # toggle sticky(+float), topmost, picture-in-picture
        alt - p : ${yabai} -m window --toggle sticky; \
                  ${yabai} -m window --toggle topmost; \
                  ${yabai} -m window --toggle pip

        # reload
        shift + alt - r : brew services restart skhd; brew services restart yabai; brew services restart sketchybar
      '';
  };
}
