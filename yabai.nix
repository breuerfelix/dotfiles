{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # Set all padding and gaps to 20pt (default: 0)
      yabai -m config top_padding    20
      yabai -m config bottom_padding 20
      yabai -m config left_padding   20
      yabai -m config right_padding  20
      yabai -m config window_gap     20

      echo "yabai configuration loaded.."
    '';
  };
}
