{ config, pkgs, lib, ... }: {
  home.file.polybar = {
    executable = true;
    target = ".config/polybar/start.sh";
    text = ''
      #!/run/current-system/sw/bin/bash

      # terminate already running bar instances
      pkill polybar

      # start polybar on all monitors
      for m in $(polybar --list-monitors | cut -d":" -f1); do
          MONITOR=$m polybar bar &
      done
    '';
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    config = ./polybar.ini;

    # i3 handles launching polybar
    # at the time nix launches polybar
    # there is no information about monitors available
    script = "exit 0";
  };
}
