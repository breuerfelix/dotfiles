{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # load scripting addition
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      yabai -m config layout bsp
      yabai -m config auto_balance off
      yabai -m config window_topmost on

      yabai -m config top_padding    0
      yabai -m config bottom_padding 0
      yabai -m config left_padding   0
      yabai -m config right_padding  0
      yabai -m config window_gap     0

      # rules
      yabai -m rule --add app="^System Preferences$" manage=off

      echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      # focus window
      alt - h : /opt/homebrew/bin/yabai -m window --focus west
      alt - j : /opt/homebrew/bin/yabai -m window --focus south
      alt - k : /opt/homebrew/bin/yabai -m window --focus north
      alt - l : /opt/homebrew/bin/yabai -m window --focus east

      # swap managed window
      shift + alt - h : /opt/homebrew/bin/yabai -m window --swap west
      shift + alt - j : /opt/homebrew/bin/yabai -m window --swap south
      shift + alt - k : /opt/homebrew/bin/yabai -m window --swap north
      shift + alt - l : /opt/homebrew/bin/yabai -m window --swap east

      # fast focus desktop
      # cmd + alt - x : yabai -m space --focus recent
      # cmd + alt - 1 : yabai -m space --focus 1

      # send window to desktop and follow focus
      # shift + cmd - z : yabai -m window --space next; yabai -m space --focus next
      # shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2

      # increase window size
      shift + alt - a : /opt/homebrew/bin/yabai -m window --resize left:-20:0
      shift + alt - s : /opt/homebrew/bin/yabai -m window --resize right:-20:0
      # shift + alt - w : yabai -m window --resize top:0:-20

      # decrease window size
      # shift + cmd - s : yabai -m window --resize bottom:0:-20
      # shift + cmd - w : yabai -m window --resize top:0:20

      # float / unfloat window and center on screen
      alt - t : /opt/homebrew/bin/yabai -m window --toggle float; \
                /opt/homebrew/bin/yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky(+float), topmost, picture-in-picture
      alt - p : /opt/homebrew/bin/yabai -m window --toggle sticky; \
                /opt/homebrew/bin/yabai -m window --toggle topmost; \
                /opt/homebrew/bin/yabai -m window --toggle pip
    '';
  };
}
