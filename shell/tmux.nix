{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "o";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = lib.strings.fileContents ./tmux.conf;
  };
}
