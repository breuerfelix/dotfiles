{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/spacebar/spacebarrc";
    text = ''
    '';
  };
}
