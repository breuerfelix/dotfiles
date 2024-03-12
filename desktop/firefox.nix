{ config, pkgs, lib, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };
}
